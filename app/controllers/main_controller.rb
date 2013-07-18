require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController

  def index
    @sources = EventSource.all

    @doc = Nokogiri::HTML(open(@sources.first.url))

    @events = @doc.css('#event-listing ul.events li')

    # embedly_api = Embedly::API.new :key => 'a93b3ce30d4a4625a92d4881f39d9aff', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
    # url = @events.first
    # obj = embedly_api.preview :url => url
    # puts JSON.pretty_generate(obj[0].marshal_dump)
  end

  def add_source
    urls = YAML.load_file "path/to/yml_file.yml"
    urls["Name"] = ABC
    File.open("path/to/yml_file.yml", 'w') { |f| YAML.dump(urls, f) }
  end
end
