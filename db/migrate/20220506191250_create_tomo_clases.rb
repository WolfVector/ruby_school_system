class CreateTomoClases < ActiveRecord::Migration[7.0]
  def change
    create_table :tomo_clases do |t|
      t.references :imparto_clase, null: false, foreign_key: { to_table: :imparto_clases }
      t.references :alumno, null: false, foreign_key: { to_table: :auth_users }

      t.timestamps
    end
  end
end
