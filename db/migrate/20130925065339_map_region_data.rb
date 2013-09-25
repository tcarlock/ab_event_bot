class MapRegionData < ActiveRecord::Migration
  def change
    EventSource.all.each do |source|
      source.update_attribute :region, 'SanFranciscoCa'
    end
  end
end
