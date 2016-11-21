class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :dob, :datetime
    add_column :users, :gender, :string
    add_column :users, :location, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :diving_since, :integer
    add_column :users, :certifications, :string, array: true, default: []
  end
end
