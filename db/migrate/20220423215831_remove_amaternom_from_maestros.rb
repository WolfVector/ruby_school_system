class RemoveAmaternomFromMaestros < ActiveRecord::Migration[7.0]
  def change
    remove_column :maestros, :amaternom, :string
  end
end
