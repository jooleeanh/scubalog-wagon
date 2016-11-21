class CreateDivesites < ActiveRecord::Migration[5.0]
  def change
    create_table :divesites do |t|
      t.string :name
      t.string :location
      t.float :longitude
      t.float :latitude
      t.string :diffulty
      t.float :max_depth
      t.float :avg_depth
      t.boolean :freshwater, default: false

      t.timestamps
    end
  end
end
