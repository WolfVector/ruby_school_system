class AddMaestroToClases < ActiveRecord::Migration[7.0]
  def change
    add_reference :clases, :maestro, null: true, foreign_key: true, on_update: :cascade, on_delete: :nullify 
  end
end
