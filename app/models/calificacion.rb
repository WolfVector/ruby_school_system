class Calificacion < ApplicationRecord
  belongs_to :periodo
  belongs_to :tomo_clase
  

  def get_nota_or(char)
    if calificacion.nil?
      char
    else
      calificacion * 10
    end
  end

  def disabled?
    if habilitar
      ""
    else
      "disabled"
    end
  end

  def disabled_message?
    if habilitar
      ""
    else
      "Deshabilitada"
    end
  end
end
