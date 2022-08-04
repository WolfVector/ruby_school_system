class CreateCarreras < ActiveRecord::Migration[7.0]
  def change
    create_table :carreras do |t|
      t.string :carrera

      t.timestamps
    end
  end
end
