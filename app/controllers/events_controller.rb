class EventsController < ApplicationController
  before_filter :get_event, only: [:edit, :update, :approve, :reject]

  def edit

  end

  def update
    @event.update_attributes(params[:event].merge(edited: true))

    unless params[:post_event] == 'false'
      @event.update_attributes(
        processed: true,
        posted: true
      )

      event_hash = {
        title: @event.title,
        subtitle: @event.subtitle,
        description: @event.description,
        location: @event.location,
        start_time: @event.start_date,
        price: @event.price,
        image_link: @event.media_url,
        ticket_link: @event.ticket_url,
        link: @event.event_url,
        category: @event.category,
        keywords: @event.keywords[0..4].sort { |k1, k2| k1['score'] <=> k2['score'] }.reverse.map { |k| k['name'] }.join(', '),
        image_urls: @event.image_urls.map { |i| i['url'] }.join(', ')
      }

      Curl.post('http://applebutter.me/event-bot-posting/', event_hash)

      redirect_to root_url, notice: 'This event has been posted to AppleButter'
    else
      redirect_to root_url, notice: 'This event has been updated'
    end
  end

  def reject
    @event.update_attributes(
      processed: true,
      posted: false
    )

    redirect_to root_url, notice: 'This event has been rejected'
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
