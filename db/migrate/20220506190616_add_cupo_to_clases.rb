class AddCupoToClases < ActiveRecord::Migration[7.0]
  def change
    add_column :clases, :cupo, :integer
  end
end
