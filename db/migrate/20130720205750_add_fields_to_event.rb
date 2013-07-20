class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :event_source_id, :integer
    add_column :events, :date_time_string, :string
    add_column :events, :location, :string
    add_column :events, :subtitle, :string
    add_column :events, :category, :string
    add_column :events, :event_url, :string
    add_column :events, :ticket_url, :string
    add_column :events, :media_url, :string
    add_column :events, :price, :string
  end
end
