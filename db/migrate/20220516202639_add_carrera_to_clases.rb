class AddCarreraToClases < ActiveRecord::Migration[7.0]
  def change
    add_reference :clases, :carrera, null: true, foreign_key: true, on_update: :cascade, on_delete: :nullify
  end
end
