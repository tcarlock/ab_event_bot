desc "This task scrapes events from all active event sources"
task :scrape_events => :environment do
  EventScraper.get_yo_scrape_on EventSource.active
end