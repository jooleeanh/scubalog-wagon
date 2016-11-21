class CreateDives < ActiveRecord::Migration[5.0]
  def change
    create_table :dives do |t|
      t.references :user, foreign_key: true
      t.references :divesite, foreign_key: true
      t.datetime :datetime
      t.string :type
      t.integer :tank_size
      t.integer :bottom_time
      t.integer :start_air
      t.integer :end_air
      t.float :max_depth
      t.float :avg_depth
      t.float :min_temp
      t.float :max_temp
      t.text :comments
      t.integer :enjoyment
      t.integer :visibility
      t.text :polygon, array: true, default: []
      t.integer :review_rating
      t.text :review_content

      t.timestamps
    end
  end
end
