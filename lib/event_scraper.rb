require 'nokogiri'
require 'open-uri'

module EventScraper
  def self.get_yo_scrape_on sources
    tag_score_threshold = 15
    results = []

    sources.each do |source|
      # source_results = {}
      # source_results[:url] = source.url
      # source_results[:host] = URI(source.url).host
      # source_results[:events] = []

      Nokogiri::HTML(open(source.url)).css(source.event_item_selector).each do |item|
        event_url = item.css(source.title_link_selector).first.attributes['href'].value
        event = Event.find_or_initialize_by_event_url(event_url)
        meta_data = EventScraper.api_call(event.event_url)

        event.update_attributes(
          event_source_id: source.id,
          title: item.css(source.title_link_selector).first.content,
          location: item.css(source.location_selector).first.content,
          date_time_string: item.css(source.date_selector).first.content.strip,
          event_url: item.css(source.title_link_selector).first.attributes['href'].value,
          description: (meta_data['description'] || '').strip,
          image_urls: meta_data['images'] || [],
          keywords: meta_data['keywords'].select { |tag| tag['score'].to_i > tag_score_threshold }
        )

        # source_results[:events] << event
      end
      # results << source_results
    end

    results
  end

  def self.api_call url
    JSON.parse(Curl.get("http://api.embed.ly/1/extract?key=a93b3ce30d4a4625a92d4881f39d9aff&url=#{url}").body_str)
  end
end