class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :divesite, foreign_key: true
      t.datetime :datetime

      t.timestamps
    end
  end
end
