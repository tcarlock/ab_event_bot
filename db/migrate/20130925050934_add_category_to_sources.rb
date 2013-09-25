class AddCategoryToSources < ActiveRecord::Migration
  def change
    add_column :event_sources, :category, :string

    EventSource.all.each do |source|
      source.update_attribute :category, 'General'
    end
  end
end
