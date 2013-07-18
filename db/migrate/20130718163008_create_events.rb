class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :keywords
      t.text :image_urls
      t.datetime :start_date
      t.boolean :reviewed
      t.boolean :approved

      t.timestamps
    end
  end
end
