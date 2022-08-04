class AddFinToClases < ActiveRecord::Migration[7.0]
  def change
    add_column :clases, :fin, :time
  end
end
