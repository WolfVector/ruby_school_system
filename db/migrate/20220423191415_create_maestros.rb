class CreateMaestros < ActiveRecord::Migration[7.0]
  def change
    create_table :maestros do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :nombre, null: false
      t.string :apaterno, null: false
      t.string :amaternom, null: false
      t.string :grado

      t.timestamps
    end

    add_index :maestros, :email, unique: true
  end
end
