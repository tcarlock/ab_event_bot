class MainController < ApplicationController

  def index
    @sources = EventSource.all
    @selected_source = @sources.first

    EventScraper.get_yo_scrape_on EventSource.all

    @events = @selected_source.events
  end
end
