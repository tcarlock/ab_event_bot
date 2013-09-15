require 'nokogiri'
require 'open-uri'

module EventScraper
  def self.get_yo_scrape_on sources
    results = []

    sources.each do |source|
      begin
        if source.url.include? 'PAGE_NUMBER'   # Page-parameterized URL; Iterate over each param value and process resulting URL on its own
          (1..source.url_params[:PAGE_NUMBER].to_i).each do |page|
            parameterized_url = source.url.gsub('{PAGE_NUMBER}', page.to_s)
            EventScraper.process_source source, parameterized_url
          end
        else
          EventScraper.process_source source, source.url
        end

        source.update_attributes(last_scraped: Time.now)
      rescue => e
        Rails.logger.warn "Aw shit, son. There was an error parsing the source '#{source.title}': #{e}"
        Rails.logger.warn e.backtrace
        next
      end
    end

    results
  end

  def self.process_source source, url
    Rails.logger.info "Scraping #{url}..."

    Nokogiri::HTML(open(url.strip)).css(source.event_link_selector.strip).each do |item|
      begin
        event_url = item.attributes['href'].value

        # Make sure URL is fully formatted
        if event_url.index('/') == 0   # Relative URL, normalize
          source_uri = URI(url.strip)
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
          date_time_string = "#{EventScraper.process_tag(event_details_dom, source.date_selector)} #{EventScraper.process_tag(event_details_dom, source.time_selector)}"

          event.update_attributes(
            event_source_id: source.id,
            venue_id: source.venue_id,
            title: EventScraper.process_tag(event_details_dom, source.title_selector),
            description: EventScraper.process_tag(event_details_dom, source.description_selector),
            location: EventScraper.process_tag(event_details_dom, source.location_selector),
            date_time_string: date_time_string,
            event_url: event_url,
            ticket_url: EventScraper.process_tag(event_details_dom, source.ticket_url_selector),
            image_urls: meta_data['images'] || [],
            keywords: (meta_data['keywords'] || []).select { |tag| tag['score'].to_i > TAG_SCORE_THRESHOLD }
          )

          # Parse scraped date
          Time.zone = "UTC"
          Chronic.time_class = Time.zone
          parsed_date = Chronic.parse(event.date_time_string)

          Rails.logger.info "Date string '#{event.date_time_string}' parsed as #{parsed_date.to_s}"
          event.update_attributes(start_date: parsed_date)
        end
      rescue => e
        Rails.logger.warn "Aw shit, son. There was an error parsing an event from '#{source.title}': #{e}"
        Rails.logger.warn e.backtrace
        next
      end
    end
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