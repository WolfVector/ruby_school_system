class AddModificationToMaestros < ActiveRecord::Migration[7.0]
  def change
    change_column :maestros, :remember_token, :string, null: false
  end
end
