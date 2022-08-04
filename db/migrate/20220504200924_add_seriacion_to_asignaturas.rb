class AddSeriacionToAsignaturas < ActiveRecord::Migration[7.0]
  def change
    add_reference :asignaturas, :seriada,  foreign_key: { to_table: :asignaturas }
  end
end
