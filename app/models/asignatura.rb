class Asignatura < ApplicationRecord
	has_many :abre_materias, class_name: "Asignatura", foreign_key: "seriada_id"
	belongs_to :seriada, class_name: "Asignatura", optional: true
	has_many :clase
end
