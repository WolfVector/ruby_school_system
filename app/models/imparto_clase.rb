class ImpartoClase < ApplicationRecord
  belongs_to :clase
  belongs_to :maestro
  #has_many :alumnos, class_name: "TomoClase", dependent: :destroy

  #def count_alumnos
  #  alumnos.length
  #end
end
