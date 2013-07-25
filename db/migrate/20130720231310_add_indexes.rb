class AddIndexes < ActiveRecord::Migration
  def change
    add_index :events, [:event_source_id, :processed]
  end
end
