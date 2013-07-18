class CreateEventSources < ActiveRecord::Migration
  def change
    create_table :event_sources do |t|
      t.string :url
      t.datetime :last_scraped

      t.timestamps
    end
  end
end
