class AddTitleToEventSource < ActiveRecord::Migration
  def change
    add_column :event_sources, :title, :string
    add_column :event_sources, :region, :string
  end
end
