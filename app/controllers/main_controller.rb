class MainController < ApplicationController

  def index
    @categories = EventSource::CATEGORIES.map { |k,v| [k.to_s.camelize, v] }
    @selected_category = @categories.select { |category| category[0] == params[:category] }[0] || ''

    @sources = EventSource.active.order(:title)

    unless params[:category].nil?
      @sources = @sources.where(category: params[:category])
    end

    @regions = EventSource::REGIONS.map { |k,v| [k.to_s.camelize, v] }
    @selected_region = @regions.select { |region| region == params[:region] }[0] || @regions.first
  end

  def process_events
    EventScraper.get_yo_scrape_on EventSource.active

    redirect_to root_url, notice: 'Done'
  end
end
