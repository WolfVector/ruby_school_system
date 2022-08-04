class RemoveAsignaturaIdFromAsignaturas < ActiveRecord::Migration[7.0]
  def change
    remove_column :asignaturas, :asignatura_id, :integer
  end
end
