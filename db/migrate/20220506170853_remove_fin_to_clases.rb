class RemoveFinToClases < ActiveRecord::Migration[7.0]
  def change
    remove_column :clases, :fin, :time
  end
end
