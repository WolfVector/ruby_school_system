class CreateAsignaturas < ActiveRecord::Migration[7.0]
  def change
    create_table :asignaturas do |t|
      t.string :asignatura, null: false
      t.references :asignatura, foreign_key: true, on_update: :cascade, on_delete: :nullify

      t.timestamps
    end
  end
end
