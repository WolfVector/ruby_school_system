class CreateClases < ActiveRecord::Migration[7.0]
  def change
    create_table :clases do |t|
      t.references :asignatura, null: false, foreign_key: true
      t.references :periodo, null: false, foreign_key: true
      t.string :grupo, null: false

      t.timestamps
    end

    add_index :clases, :grupo, unique: true
  end
end
