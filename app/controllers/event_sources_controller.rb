class EventSourcesController < ApplicationController
  before_filter :get_source, only: [:edit, :update, :destroy]

  def index
    @sources = EventSource.active.order(:title)
  end

  def new
    @source = EventSource.new
  end

  def create
    @source = EventSource.new(params[:event_source])

    if @source.save
      redirect_to event_sources_url
    else
      render 'new'
    end
  end

  def update
    @source.update_attributes(params[:event_source])
    redirect_to event_sources_url, notice: 'This source has been updated'
  end

  def destroy
    @source.update_attributes(disabled: true)
    redirect_to event_sources_url, notice: 'This source has been disabled'
  end

  private

  def get_source
    @source = EventSource.find(params[:id])
  end
end
