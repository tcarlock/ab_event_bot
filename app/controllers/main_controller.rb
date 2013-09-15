class MainController < ApplicationController

  def index
    @sources = EventSource.active.order(:title)
  end

  def process_events
    EventScraper.get_yo_scrape_on EventSource.active

    redirect_to root_url, notice: 'Done'
  end
end
