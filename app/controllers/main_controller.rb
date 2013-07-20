class MainController < ApplicationController

  def index
    @sources = EventSource.all
    @results = EventScraper.get_yo_scrape_on EventSource.all
  end
end
