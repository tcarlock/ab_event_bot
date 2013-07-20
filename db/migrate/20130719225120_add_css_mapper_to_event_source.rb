class AddCssMapperToEventSource < ActiveRecord::Migration
  def change
    add_column :event_sources, :css_mappers, :text
  end
end
