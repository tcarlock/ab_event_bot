class EventsController < ApplicationController

  def edit
    @event = Event.find_by_id(params[:id])
  end

  def update
    @event = Event.find_by_id(params[:id])

    @event.update_attributes(params[:event])
    redirect_to root_url, notice: 'This event has been updated'
  end

  def approve_event

  end

  def preview_json
    event = Event.find_by_id(params[:id])
    render partial: 'events/event', locals: { event: event }
  end
end
