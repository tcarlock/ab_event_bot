class EventsController < ApplicationController
  before_filter :get_event, only: [:edit, :update, :approve, :reject]

  def edit

  end

  def update
    @event.update_attributes(params[:event].merge(edited: true))
    redirect_to root_url, notice: 'This event has been updated'
  end

  def approve
    @event.update_attributes(
      processed: true,
      posted: true
    )

    redirect_to root_url, notice: 'This event has been updated'
  end

  def reject
    @event.update_attributes(
      processed: true,
      posted: false
    )

    redirect_to root_url, notice: 'This event has been updated'
  end

  def preview_json
    event = Event.find_by_id(params[:id])
    render partial: 'events/event', locals: { event: event }
  end

  private

  def get_event
    @event = Event.find_by_id(params[:id])
  end
end
