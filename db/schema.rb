# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130925065339) do

  create_table "event_sources", :force => true do |t|
    t.string   "url"
    t.datetime "last_scraped"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "css_mappers"
    t.string   "title"
    t.string   "region"
    t.boolean  "disabled",     :default => false
    t.text     "url_params"
    t.integer  "venue_id"
    t.string   "category"
  end

  add_index "event_sources", ["disabled"], :name => "index_event_sources_on_disabled"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.text     "image_urls"
    t.datetime "start_date"
    t.boolean  "edited",           :default => false
    t.boolean  "processed",        :default => false
    t.boolean  "posted",           :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "event_source_id"
    t.string   "date_time_string"
    t.string   "location"
    t.string   "subtitle"
    t.string   "category"
    t.text     "event_url"
    t.text     "ticket_url"
    t.text     "media_url"
    t.string   "price"
    t.integer  "venue_id"
  end

  add_index "events", ["event_source_id", "processed"], :name => "index_events_on_event_source_id_and_processed"

end
