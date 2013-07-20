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

ActiveRecord::Schema.define(:version => 20130720205750) do

  create_table "event_sources", :force => true do |t|
    t.string   "url"
    t.datetime "last_scraped"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "css_mappers"
    t.string   "title"
    t.string   "region"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.text     "image_urls"
    t.datetime "start_date"
    t.boolean  "reviewed"
    t.boolean  "approved"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "event_source_id"
    t.string   "date_time_string"
    t.string   "location"
    t.string   "subtitle"
    t.string   "category"
    t.string   "event_url"
    t.string   "ticket_url"
    t.string   "media_url"
    t.string   "price"
  end

end
