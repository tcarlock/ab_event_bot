class EventSourcesController < ApplicationController
  before_filter :get_source, only: [:edit, :update, :destroy]

  def index
    @sources = EventSource.all
  end

  def update
    @source.update_attributes(params[:event_source])
    redirect_to event_sources_url, notice: 'This source has been updated'
  end

  def destroy
    @source.destroy
    redirect_to event_sources_url, notice: 'This source has been removed'
  end

  private 

  def get_source
    @source = EventSource.find(params[:id])
  end
end
