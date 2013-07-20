class EventSource < ActiveRecord::Base
  attr_accessible :url, :last_scraped, :event_item_selector, :title_link_selector, :location_selector, :date_selector
  store :css_mappers, accessors: [ :event_item_selector, :title_link_selector, :location_selector, :date_selector ]

end
