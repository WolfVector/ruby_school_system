class CreateImpartoClases < ActiveRecord::Migration[7.0]
  def change
    create_table :imparto_clases do |t|
      t.references :clase, null: false, foreign_key: true
      t.references :maestro, null: false, foreign_key: true

      t.timestamps
    end
  end
end
