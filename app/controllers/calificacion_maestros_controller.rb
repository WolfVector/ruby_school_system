class CalificacionMaestrosController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si el usuario no ha iniciado sesión, no permitas que entre a:
	before_action :authenticate_user!, only: [:index]

	helper_method :calificacion_total

	def authenticate_user!
		redirect_to '/auth', alert: "Es necesario que inicies sesión" unless session[:current_user_id].present? && session[:rol] == 2
	end

	def index
		@imparto = Clase.where(maestro_id: current_user.id, periodo_id: params[:id]).all
	end

	def show_all
		@clase = Clase.select(:id, 'asignaturas.asignatura AS materia').where(id: params[:id]).joins(:asignatura).take
		@tomas_clases = TomoClase.where('clase_id=? AND clases.maestro_id=?', params[:id], current_user.id).joins(:clase).joins(:alumno).order('auth_users.apaterno').all
	end

	def nota_new
		toma_clase = TomoClase.find(params[:id])
		calificacions = toma_clase.calificacion.order('codigo').all
		@parcial1 = calificacions[0]
		@parcial2 = calificacions[1]
		@parcial3 = calificacions[2]
		@final = calificacions[3]
	end

	def nota_add
		nota = Calificacion.where(id: params[:id], habilitar: true).joins(:tomo_clase).joins("INNER JOIN clases ON clases.id=tomo_clases.clase_id").where('clases.maestro_id=?', current_user.id).take

		if nota.blank?
			render json: { "ok" => false, "msg" => "Operación no permitida" }
		elsif nota.update(calificacion: params[:value])
			common_json = { "ok" => true }

			if nota.codigo != Constants::EDUCA_FINAL
				render json: common_json
				return
			end

			if !clase_aprobada?(nota.tomo_clase_id)
				render json: common_json
				return
			end

			tomo_clase = TomoClase.find(nota.tomo_clase_id)

			if tomo_clase.update(aprobada: true)
				render json: common_json
			else
				render json: { "ok" => false, "msg" => "La calificación fue subida con éxito, pero no se marcó la clase como aprobada"}
			end

		else
			render json: { "ok" => false, "msg" => "Hubo un problema al subir la calificación" }
		end
	end

	private
		def clase_aprobada?(id)
			notas = Calificacion.where(tomo_clase_id: id).order('codigo').all
			if CalificacionAlumnosController.calificacion_total(notas[0].calificacion, notas[1].calificacion, notas[2].calificacion, notas[3].calificacion) >= 7.0
				true
			else
				false
			end
		end
end
