class Event < ActiveRecord::Base
  attr_accessible :event_source_id, :title, :location, :date, :date_time_string, :description, :subtitle, :category, :event_url, :ticket_url, :media_url, :price

  has_one :event_source
end
