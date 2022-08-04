class AddRolToMaestros < ActiveRecord::Migration[7.0]
  def change
    add_column :maestros, :rol, :integer
  end
end
