class ChangeColumnInDivesite < ActiveRecord::Migration[5.0]
  def change
    rename_column :divesites, :diffulty, :difficulty
  end
end
