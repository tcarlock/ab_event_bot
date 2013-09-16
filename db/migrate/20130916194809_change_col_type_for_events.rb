class ChangeColTypeForEvents < ActiveRecord::Migration
  def change
    change_column :events, :event_url, :text
    change_column :events, :ticket_url, :text
    change_column :events, :media_url, :text
  end
end
