class CreateSightings < ActiveRecord::Migration[5.0]
  def change
    create_table :sightings do |t|
      t.references :dive, foreign_key: true
      t.references :animal, foreign_key: true

      t.timestamps
    end
  end
end
