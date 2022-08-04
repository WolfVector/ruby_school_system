class Horario < ApplicationRecord
  belongs_to :clase

  def get_horario
    get_hora + " - " + get_min
  end

  def get_hora
    "#{hora.to_fs(:time)}"
  end

  def get_min
    "#{fin.to_fs(:time)}"
  end

end
