class AddClaseToTomoClase < ActiveRecord::Migration[7.0]
  def change
    add_reference :tomo_clases, :clase, null: false, foreign_key: true, on_update: :cascade, on_delete: :cascade
    remove_column :tomo_clases, :imparto_clase_id
  end
end
