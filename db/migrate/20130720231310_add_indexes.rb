class AddIndexes < ActiveRecord::Migration
  def change
    add_index :events, :event_source_id
  end
end
