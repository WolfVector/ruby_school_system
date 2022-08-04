class AddConfirmationToMaestros < ActiveRecord::Migration[7.0]
  def change
    add_column :maestros, :confirmed_at, :datetime
  end
end
