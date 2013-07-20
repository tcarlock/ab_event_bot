EventSource.create(
  title: '7x7',
  region: 'San Francisco, CA',
  url: 'http://events.7x7.com/search?when=future&featured=1&sort_by=date',
  event_item_selector: '#event-listing ul.events li',
  title_link_selector: 'h4 a',
  location_selector: 'p.venue',
  date_selector: 'p.start-time',
  last_scraped: Time.now
)