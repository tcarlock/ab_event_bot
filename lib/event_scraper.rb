# require 'processor_queue'
# require 'json'
# require 'curb'                              # to poll embed.ly

Dir[File.dirname(__FILE__) + '/event_source_processors/*.rb'].each {|file| require file}

module EventScraper
  class Event
    attr_accessor :title, :location, :date, :url, :tags
  end

  def self.get_yo_scrape_on sources
    tag_score_threshold = 15
    results = []

    # queue = ProcessorQueue.new do
    #   use Processors::SevenBySevenProcessor
    # end

    sources.each do |source|
      # source_results = {}
      # source_results[:events] = queue.process(source.url)
      # source_results[:url] = source.url
      # results << source_results

      source_results = {}
      source_results[:url] = source.url
      source_results[:host] = URI(source.url).host
      source_results[:events] = []

      Nokogiri::HTML(open(source.url)).css(source.event_item_selector).each do |item|
        event = Event.new
        event.title = item.css(source.title_link_selector).first.content
        event.location = item.css(source.location_selector).first.content
        event.date = item.css(source.date_selector).first.content
        event.url = item.css(source.title_link_selector).first.attributes['href'].value

        # embedly_api = Embedly::API.new :key => 'a93b3ce30d4a4625a92d4881f39d9aff', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'

        data = EventScraper.api_call(event.url)

        event.tags = data['keywords'].select { |tag| tag['score'].to_i > tag_score_threshold }

        source_results[:events] << event
      end
      results << source_results
    end

    results
  end

  def self.api_call url
    JSON.parse(Curl.get("http://api.embed.ly/1/extract?key=a93b3ce30d4a4625a92d4881f39d9aff&url=#{url}").body_str)
  end
end