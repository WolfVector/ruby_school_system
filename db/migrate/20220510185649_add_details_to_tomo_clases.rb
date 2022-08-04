class AddDetailsToTomoClases < ActiveRecord::Migration[7.0]
  def change
    add_column :tomo_clases, :aprobada, :boolean
    add_column :tomo_clases, :asistencias, :integer
    add_column :tomo_clases, :faltas, :integer
    add_reference :tomo_clases, :parcial1, null: false, foreign_key: { to_table: :calificacions }, on_update: :cascade, on_delete: :nullify 
    add_reference :tomo_clases, :parcial2, null: false, foreign_key: { to_table: :calificacions }, on_update: :cascade, on_delete: :nullify
    add_reference :tomo_clases, :parcial3, null: false, foreign_key: { to_table: :calificacions }, on_update: :cascade, on_delete: :nullify
    add_reference :tomo_clases, :final, null: false, foreign_key: { to_table: :calificacions }, on_update: :cascade, on_delete: :nullify
    add_reference :tomo_clases, :extraordinario, null: false, foreign_key: { to_table: :calificacions }, on_update: :cascade, on_delete: :nullify
    add_reference :tomo_clases, :regularizacion, null: false, foreign_key: { to_table: :calificacions }, on_update: :cascade, on_delete: :nullify
  end
end
