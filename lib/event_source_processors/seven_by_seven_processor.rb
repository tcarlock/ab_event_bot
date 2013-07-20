require 'nokogiri'
require 'open-uri'

module EventScraper
  module Processors
    class SevenBySevenProcessor

      def is_handler
        URI(url).host == "events.7x7.com"
      end

      def process(url)
        if 
          doc = Nokogiri::HTML(open(url))

          # Return events
          doc.css('#event-listing ul.events li')
        end
      end
    end
  end
end