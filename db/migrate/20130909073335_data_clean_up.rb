class DataCleanUp < ActiveRecord::Migration
  def change
    EventSource.all.each do |source|
      source.update_attributes(event_item_selector: nil, title_link_selector: nil)
    end
  end
end
