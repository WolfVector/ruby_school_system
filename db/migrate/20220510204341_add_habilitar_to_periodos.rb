class AddHabilitarToPeriodos < ActiveRecord::Migration[7.0]
  def change
    add_column :periodos, :habilitar, :boolean
  end
end
