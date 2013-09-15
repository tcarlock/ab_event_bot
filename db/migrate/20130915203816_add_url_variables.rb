class AddUrlVariables < ActiveRecord::Migration
  def change
    add_column :event_sources, :url_params, :text
  end
end
