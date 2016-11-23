class ChangeTypeToTypesInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :dives, :type, :types
  end
end
