class MainController < ApplicationController

  def index
    @sources = EventSource.all
    EventScraper.get_yo_scrape_on EventSource.all

    
  end
end
