class RemoveColumnsFromTomoClase < ActiveRecord::Migration[7.0]
  def change
    remove_column :tomo_clases, :parcial1_id
    remove_column :tomo_clases, :parcial2_id
    remove_column :tomo_clases, :parcial3_id
    remove_column :tomo_clases, :final_id
    remove_column :tomo_clases, :extraordinario_id
    remove_column :tomo_clases, :regularizacion_id
  end
end
