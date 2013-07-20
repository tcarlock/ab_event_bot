class MainController < ApplicationController

  def index
    @results = EventScraper.get_yo_scrape_on EventSource.all

    # @doc = Nokogiri::HTML(open(EventSource.first.url))

    # @events = @doc.css('#event-listing ul.events li')

    # embedly_api = Embedly::API.new :key => 'a93b3ce30d4a4625a92d4881f39d9aff', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    # url = @events.first
    # obj = embedly_api.preview :url => url
    # puts JSON.pretty_generate(obj[0].marshal_dump)
  end
end
