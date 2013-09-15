class AddVenueIdToEventSources < ActiveRecord::Migration
  def change
    add_column :event_sources, :venue_id, :integer
    add_column :events, :venue_id, :integer
  end
end
