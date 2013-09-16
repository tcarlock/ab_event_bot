class EventSource < ActiveRecord::Base
  before_create :set_scrape_date
  # after_initialize :set_url_param_defaults
  before_validation :add_url_protocol

  URL_PARAMS = {
    PAGE_NUMBER: 5
  }

  attr_accessible :venue_id, :title, :region, :url, :url_params, :last_scraped, :event_link_selector, :title_selector, :description_selector, :location_selector, :date_selector, :time_selector, :ticket_url_selector, :disabled, :event_item_selector, :title_link_selector
  store :css_mappers, accessors: [:event_link_selector, :title_selector, :description_selector, :location_selector, :date_selector, :time_selector, :ticket_url_selector, :event_item_selector, :title_link_selector]
  serialize :url_params, HashWithIndifferentAccess

  validates :title, presence: :true
  validates :region, presence: :true
  validates :url, presence: :true
  validates :event_link_selector, presence: :true
  validates :title_selector, presence: :true
  validates :location_selector, presence: :true
  validates :date_selector, presence: :true

  has_many :events

  scope :active, where(disabled: false)

  private

  def set_scrape_date
    self.last_scraped = Time.now
  end

  def add_url_protocol
    unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
      self.url = 'http://' + self.url
    end
  end

  # def set_url_param_defaults
  #   URL_PARAMS.each do |key, value|
  #     self.url_params[key] = value if self.url_params[key].nil?
  #   end
  # end
end
