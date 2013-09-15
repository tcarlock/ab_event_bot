desc "This task scrapes events from all active event sources"
task :scrape_events => :environment do
  if defined?(Rails) && (Rails.env == 'development')
    Rails.logger = Logger.new(STDOUT)
  end

  EventScraper.get_yo_scrape_on EventSource.active
end