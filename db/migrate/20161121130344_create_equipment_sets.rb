class CreateEquipmentSets < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment_sets do |t|
      t.references :user, foreign_key: true
      t.string :mask
      t.string :snorkel
      t.string :fins
      t.string :wetsuit
      t.string :computer
      t.string :bcd
      t.string :regulator
      t.float :weight

      t.timestamps
    end
  end
end
