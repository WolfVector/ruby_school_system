class CreatePeriodos < ActiveRecord::Migration[7.0]
  def change
    create_table :periodos do |t|
      t.string :periodo, null: false

      t.timestamps
    end
  end
end
