class MainController < ApplicationController

  def index
    @sources = EventSource.all
    @selected_source = params[:source] || @sources.first
    @events = @selected_source.events
  end

  def process_events
    EventScraper.get_yo_scrape_on EventSource.all

    redirect_to root_url
  end
end
