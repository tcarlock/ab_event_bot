class Event < ActiveRecord::Base
  attr_accessible :venue_id, :event_source_id, :title, :location, :start_date, :date_time_string, :description, :subtitle, :category, :image_urls, :keywords, :event_url, :ticket_url, :media_url, :price, :edited, :processed, :posted

  serialize :image_urls, Array
  serialize :keywords, Array

  belongs_to :event_source

  scope :unprocessed, where(processed: false)
end
