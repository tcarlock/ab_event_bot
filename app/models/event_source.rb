class EventSource < ActiveRecord::Base
  attr_accessible :url, :last_scraped
end
