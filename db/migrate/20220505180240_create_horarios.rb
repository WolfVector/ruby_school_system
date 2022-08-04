class CreateHorarios < ActiveRecord::Migration[7.0]
  def change
    create_table :horarios do |t|
      t.references :clase, null: false, foreign_key: true, on_update: :cascade, on_delete: :cascade
      t.time :hora
      t.string :dia

      t.timestamps
    end
  end
end
