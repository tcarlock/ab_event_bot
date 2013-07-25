class MainController < ApplicationController

  def index
    @sources = EventSource.active

    if @sources.length > 0
      @selected_source = @sources.find_by_id(params[:source]) || @sources.first
      @events =  @selected_source.events.where(processed: false).order(:created_at)
    end
  end

  def process_events
    EventScraper.get_yo_scrape_on EventSource.active

    redirect_to root_url, notice: 'Done'
  end
end
