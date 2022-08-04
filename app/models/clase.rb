class Clase < ApplicationRecord
  belongs_to :asignatura
  belongs_to :periodo
  belongs_to :maestro
  has_many :horario, dependent: :delete_all

  has_many :alumnos, class_name: "TomoClase", dependent: :destroy

  def disponibles
    cupo - count_alumnos
  end

  def count_alumnos
    alumnos.length
  end

  def inscribir?(alumno_id)
    if asignatura.seriada.present?
      seriada_id = asignatura.seriada.id
      tomo_clases = TomoClase.where(alumno_id: alumno_id, clase_id: Clase.select(:id).where(asignatura_id: seriada_id).all).all

      if tomo_clases.blank?
        return false
      end

      tomo_clases.each do |tomo_clase|
        #Si ya aprobó la materia seriada, entonces permite la inscripción
        if tomo_clase.aprobada
          return true
        end
      end

      #Si llega a este punto, entonces la ha cursado pero aún no la ha aprobado
      false
    else
      true #La materia no está seriada, permite la inscripción
    end
  end

  def curse?(user_id, materia_id, periodo_id)
    #Obtenemos todas las veces que ha cursado la materia (recursamiento)
    tomo_clases = alumnos.where(alumno_id: user_id, clase_id: Clase.select(:id).where(asignatura_id: materia_id).all).all
    
    #Si no la ha cursado, entonces retorna falso
    if tomo_clases.blank?
      return false
    end

    tomo_clases.each do |tomo_clase|
      #Si ya la aprobó o si la acaba de inscribir, entonces no permitas que la vuela a tomar
      if tomo_clase.aprobada || tomo_clase.clase.periodo_id == periodo_id
        return true
      end
    end

    #Si llega a este punto, entonces la ha cursado pero aún no la ha aprobado
    false
  end

end
