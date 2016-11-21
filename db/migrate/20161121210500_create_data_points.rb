class CreateDataPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :data_points do |t|
      t.references :dive, foreign_key: true
      t.integer :time
      t.integer :depth
      t.integer :temp
      t.integer :air

      t.timestamps
    end
  end
end
