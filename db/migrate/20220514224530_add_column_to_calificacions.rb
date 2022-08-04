class AddColumnToCalificacions < ActiveRecord::Migration[7.0]
  def change
    add_reference :calificacions, :tomo_clase, null: false, foreign_key: { to_table: :tomo_clases }, on_update: :cascade, on_delete: :cascade
  end
end
