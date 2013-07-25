class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :keywords
      t.text :image_urls
      t.datetime :start_date
      t.boolean :edited, default: false
      t.boolean :processed, default: false
      t.boolean :posted, default: false

      t.timestamps
    end
  end
end
