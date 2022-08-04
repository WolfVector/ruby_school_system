class CreateCalificacions < ActiveRecord::Migration[7.0]
  def change
    create_table :calificacions do |t|
      t.float :calificacion
      t.boolean :habilitar, null: false
      t.integer :codigo, null: false
      t.references :periodo, null: false, foreign_key: true, on_update: :cascade, on_delete: :cascade

      t.timestamps
    end
  end
end
