class AddDisabledFieldToEventSource < ActiveRecord::Migration
  def change
    add_column :event_sources, :disabled, :boolean, default: false
    add_index :event_sources, [:disabled]
  end
end
