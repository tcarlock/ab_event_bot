class EventSource < ActiveRecord::Base
  attr_accessible :title, :region, :url, :last_scraped, :event_item_selector, :title_link_selector, :location_selector, :date_selector
  store :css_mappers, accessors: [:event_item_selector, :title_link_selector, :location_selector, :date_selector]

  validates :title, presence: :true 
  validates :region, presence: :true 
  validates :url, presence: :true 
  validates :event_item_selector, presence: :true 
  validates :title_link_selector, presence: :true 
  validates :location_selector, presence: :true 
  validates :date_selector, presence: :true 

  has_many :events
end
