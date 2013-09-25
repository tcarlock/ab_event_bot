class EventSourcesController < ApplicationController
  before_filter :get_source, only: [:show, :edit, :update, :destroy]

  def show
    sources = EventSource.active.order(:title)
    @source_options = EventSource.active.order(:title).map do |source|
      [
        source.id,
        "#{source.title} (#{source.events.unprocessed.count} active events)"
      ]
    end

    @selected_source = sources.find_by_id(params[:id]) || sources.first
    @events =  @selected_source.events.where(processed: false).order(:created_at)
  end

  def new
    @source = EventSource.new
    @regions = EventSource::REGIONS.map { |k,v| [k.to_s.camelize, v] }
  end

  def create
    @source = EventSource.new(params[:event_source])

    if @source.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @regions = EventSource::REGIONS.map { |k,v| [k.to_s.camelize, v] }
  end

  def update
    @source.update_attributes(params[:event_source])
    @source.update_attributes(url_params: @source.url_params.merge(params[:url_params]))

    redirect_to root_url, notice: 'This source has been updated'
  end

  def destroy
    @source.update_attributes(disabled: true)
    redirect_to root_url, notice: 'This source has been disabled'
  end

  private

  def get_source
    @source = EventSource.find(params[:id])
  end
end
