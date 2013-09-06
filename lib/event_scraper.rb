require 'nokogiri'
require 'open-uri'

module EventScraper
  def self.get_yo_scrape_on sources
    results = []

    sources.each do |source|
      begin
        Rails.logger.info "Scraping #{source.url}..."

        Nokogiri::HTML(open(source.url)).css(source.event_item_selector).each do |item|
          event_url = item.css(source.title_link_selector).first.attributes['href'].value

          if Event.exists?(event_url: event_url)
            Rails.logger.info "Existing record found for #{event_url}..."
          else
            Rails.logger.info "Adding new event for #{event_url}..."
            event = Event.new
            event_details_dom = Nokogiri::HTML(open(event_url))
            meta_data = EventScraper.embedly_api_call(event_url)

            # Extract content for provided selectors
            title = source.title_link_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(event_details_dom.css(source.title_link_selector).first.content.strip)
            description = source.description_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(event_details_dom.css(source.description_selector).first.content.strip)
            location = source.location_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(event_details_dom.css(source.location_selector).first.content.strip)
            date_time_string = source.date_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(event_details_dom.css(source.date_selector).first.content.strip)
            ticket_url = source.ticket_url_selector.blank? ? '' : event_details_dom.css(source.ticket_url_selector).first.attributes['href'].value

            event.update_attributes(
              event_source_id: source.id,
              title: title,
              description: description,
              location: location,
              date_time_string: date_time_string,
              event_url: event_url,
              ticket_url: ticket_url,
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

  def self.embedly_api_call url
    api_url = "http://api.embed.ly/1/extract?key=a93b3ce30d4a4625a92d4881f39d9aff&url=#{url}"
    Rails.logger.info "Invoking embedly with #{api_url}..."
    JSON.parse(Curl.get(api_url).body_str)
  end
end