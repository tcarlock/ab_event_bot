require 'nokogiri'
require 'open-uri'

module EventScraper
  def self.get_yo_scrape_on sources
    tag_score_threshold = 15
    results = []

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

          event.update_attributes(
            event_source_id: source.id,
            title: item.css(source.title_link_selector).first.content,
            location: item.css(source.location_selector).first.content,
            date_time_string: item.css(source.date_selector).first.content.strip,
            event_url: event_url,
            description: (meta_data['description'] || '').strip,
            image_urls: meta_data['images'] || [],
            keywords: (meta_data['keywords'] || []).select { |tag| tag['score'].to_i > tag_score_threshold }
          )
        end
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