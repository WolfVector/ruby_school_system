class AddColumnsToMaestros < ActiveRecord::Migration[7.0]
  def change
    add_column :maestros, :amaterno, :string
    add_column :maestros, :remember_token, :string, null: true
    add_index :maestros, :remember_token, unique: true
  end
end
