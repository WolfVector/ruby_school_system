class TomoClase < ApplicationRecord
  belongs_to :alumno, class_name: "Auth::User"
  belongs_to :clase, class_name: "Clase"
  has_many :calificacion, class_name: "Calificacion"

  def total?
    if calificacion[0].calificacion.nil?
      false
    else
      true
    end
  end

end
