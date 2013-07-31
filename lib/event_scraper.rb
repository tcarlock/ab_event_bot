require 'nokogiri'
require 'open-uri'

module EventScraper
  def self.get_yo_scrape_on sources
    results = []

    begin
      sources.each do |source|
        Rails.logger.info "Scraping #{source.url}..."

        Nokogiri::HTML(open(source.url)).css(source.event_item_selector).each do |item|
          event_url = item.css(source.title_link_selector).first.attributes['href'].value

          if Event.exists?(event_url: event_url)
            Rails.logger.info "Existing record found for #{event_url}..."
          else
            Rails.logger.info "Adding new event for #{event_url}..."
            event = Event.new
            meta_data = EventScraper.embedly_api_call(event_url)

            # Extract content for provided selectors
            title_val = source.title_link_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(item.css(source.title_link_selector).first.content.strip)
            location_val = source.location_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(item.css(source.location_selector).first.content.strip)
            date_time_string_val = source.date_selector.blank? ? '' : ::ActionController::Base.helpers.strip_tags(item.css(source.date_selector).first.content.strip)
            ticket_url_val = source.ticket_url_selector.blank? ? '' : item.css(source.ticket_url_selector).first.attributes['href'].value

            event.update_attributes(
              event_source_id: source.id,
              title: title_val,
              location: location_val,
              date_time_string: date_time_string_val,
              description: (meta_data['description'] || '').strip,
              event_url: event_url,
              ticket_url: ticket_url_val,
              image_urls: meta_data['images'] || [],
              keywords: (meta_data['keywords'] || []).select { |tag| tag['score'].to_i > TAG_SCORE_THRESHOLD }
            )
          end
        end

        source.update_attributes(last_scraped: Time.now)
      end

      results
    rescue => e
      Rails.logger.warn "Aw shit, son. There was an error: #{e}"
      Rails.logger.warn e.backtrace
    end
  end

  def self.embedly_api_call url
    api_url = "http://api.embed.ly/1/extract?key=a93b3ce30d4a4625a92d4881f39d9aff&url=#{url}"
    Rails.logger.info "Invoking embedly with #{api_url}..."
    JSON.parse(Curl.get(api_url).body_str)
  end
end