require 'nokogiri'
require 'open-uri'

module EventScraper
  def self.get_yo_scrape_on sources
    results = []

    sources.each do |source|
      begin
        Rails.logger.info "Scraping #{source.url}..."

        Nokogiri::HTML(open(source.url.strip)).css(source.event_link_selector.strip).each do |item|
          event_url = item.attributes['href'].value
          if event_url.index('/') == 0   # Relative URL
            source_uri = URI(source.url.strip)
            event_url = "#{source_uri.scheme}://#{source_uri.host}#{event_url}"
          end

          Rails.logger.info "Processing event found at #{event_url}..."

          if Event.exists?(event_url: event_url)
            Rails.logger.info "Existing record found for #{event_url}..."
          else
            Rails.logger.info "Adding new event for #{event_url}..."
            event = Event.new
            event_details_dom = Nokogiri::HTML(open(event_url))
            meta_data = EventScraper.embedly_api_call(event_url)

            event.update_attributes(
              event_source_id: source.id,
              title: EventScraper.process_tag(event_details_dom, source.title_selector),
              description: EventScraper.process_tag(event_details_dom, source.description_selector),
              location: EventScraper.process_tag(event_details_dom, source.location_selector),
              date_time_string: EventScraper.process_tag(event_details_dom, source.date_selector),
              event_url: event_url,
              ticket_url: EventScraper.process_tag(event_details_dom, source.ticket_url_selector),
              image_urls: meta_data['images'] || [],
              keywords: (meta_data['keywords'] || []).select { |tag| tag['score'].to_i > TAG_SCORE_THRESHOLD }
            )
          end
        end

        source.update_attributes(last_scraped: Time.now)
      rescue => e
        Rails.logger.warn "Aw shit, son. There was an error: #{e}"
        Rails.logger.warn e.backtrace
        next
      end
    end

    results
  end

  def self.process_tag(dom, selector)
    if selector.strip.blank?
      ''
    else
      element = dom.css(selector.strip).first

      if element.nil?
        ''
      else
        ::ActionController::Base.helpers.strip_tags(element.content.strip)
      end
    end
  end

  def self.embedly_api_call(url)
    api_url = "http://api.embed.ly/1/extract?key=a93b3ce30d4a4625a92d4881f39d9aff&url=#{url}"
    Rails.logger.info "Invoking embedly with #{api_url}..."
    JSON.parse(Curl.get(api_url).body_str)
  end
end