class CreateAnimals < ActiveRecord::Migration[5.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :image_url
      t.string :description

      t.timestamps
    end
  end
end
