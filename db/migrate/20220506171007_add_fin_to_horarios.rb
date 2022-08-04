class AddFinToHorarios < ActiveRecord::Migration[7.0]
  def change
    add_column :horarios, :fin, :time
  end
end
