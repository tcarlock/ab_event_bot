class EventSource < ActiveRecord::Base
  before_create :set_scrape_date

  attr_accessible :title, :region, :url, :last_scraped, :event_item_selector, :title_link_selector, :location_selector, :date_selector, :ticket_url_selector, :disabled
  store :css_mappers, accessors: [:event_item_selector, :title_link_selector, :description_selector, :location_selector, :date_selector, :ticket_url_selector]

  validates :title, presence: :true
  validates :region, presence: :true
  validates :url, presence: :true
  validates :event_item_selector, presence: :true
  validates :title_link_selector, presence: :true
  validates :location_selector, presence: :true
  validates :date_selector, presence: :true

  has_many :events

  scope :active, where(disabled: false)

  private

  def set_scrape_date
    self.last_scraped = Time.now
  end
end
