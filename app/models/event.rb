class Event < ActiveRecord::Base
  attr_accessible :event_source_id, :title, :location, :start_date, :date_time_string, :description, :subtitle, :category, :image_urls, :keywords, :event_url, :ticket_url, :media_url, :price

  serialize :image_urls, Array
  serialize :keywords, Array

  has_one :event_source
end
