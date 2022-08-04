class InscripcionesController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si el usuario no ha iniciado sesión, no permitas que entre a:
	before_action :authenticate_user!, only: [:index_periodo, :index, :agregar, :cancelar, :carrito, :create, :horarios_show, :horario_show]
	before_action :authenticate_alum_maestro!, only: [:horario_asistencia]

	def authenticate_user!
		redirect_to '/auth/login', alert: "Es necesario que te inicies sesión" unless session[:current_user_id].present? && session[:rol] == 1
	end

	def authenticate_alum_maestro!
		redirect_to '/auth/login', alert: "Es necesario que te inicies sesión" unless session[:current_user_id].present? && (session[:rol] == 1 || session[:rol] == 2)
	end

	def index_periodo
		@periodos = Periodo.all
	end

	def index
		if !Periodo.find(params[:id]).habilitar
			redirect_to inscripcion_path

			return 
		end

		if params[:f].present?
			filtro = params[:f].values 
		else
			filtro = Carrera.select(:id).all
		end

		page_number = 1
		if params[:page].present?
			page_number = params[:page]
		end

		@clases = Clase.where(periodo: params[:id], carrera_id: filtro).page(page_number)
		@periodo_id = params[:id]
	end

	def agregar
		if session[:inscripciones].nil?
			session[:inscripciones] = Array.new
		elsif session[:inscripciones].include? params[:id]
			render json: { "ok" => Constants::EDUCA_INSC_ERROR_YA_EXISTIA, "msg" => "La clase ya había sido agregada" }
			return
		elsif session[:inscripciones].length > 7
			render json: {"ok" => Constants::EDUCA_INSC_ERROR_LIMITE, "msg" => "El límite de materias es de 7"}
			return
		end

		clase = Clase.find(params[:id])

		if clase.blank?
			render json: {"ok" => false, "msg" => "Dicha clase no existe"}

			return
		end

		session[:inscripciones].push(params[:id])

		render json: { "ok" => true, "msg" => "" }
	end

	def cancelar
		if session[:inscripciones].nil? || session[:inscripciones].empty?
			render json: { "ok" => false, "msg" => "Tu carrito está vacío" }
			return
		elsif session[:inscripciones].delete(params[:id]).nil?
			render json: { "ok" => false, "msg" => "La materia no está en tu carrito" }
			return
		end

		render json: { "ok" => true, "msg" => "" }
	end

	def carrito
		if !Periodo.find(params[:id]).habilitar
			redirect_to inscripcion_path
		else
			@lista_carrito = session[:inscripciones]
			@periodo_id = params[:id]
		end
	end

	def create
		if !Periodo.find(params[:id]).habilitar
			render json: { "ok" => false, "msg" => "El periodo de inscripción está deshabilitado" }
			return
		elsif session[:inscripciones].nil? || session[:inscripciones].empty?
			render json: { "ok" => false, "msg" => "Tu carrito está vacío" }
			return
		end

		clase_ids = session[:inscripciones]

		clase_ids.each do |clase_id|
			clase = Clase.find(clase_id) 
			if !clase.inscribir?(current_user.id)
				render json: { "ok" => false, "msg" => "La clase #{clase.asignatura.asignatura} está seriada" }
				return
			elsif clase.curse?(current_user.id, clase.asignatura_id, params[:id])
				render json: { "ok" => false, "msg" => "Ya has cursado la clase #{clase.asignatura.asignatura}" }
				return
			end
		end 

		periodo_id = params[:id]

		clase_ids.each do |clase| 
			tomo_clase = TomoClase.new(
				alumno_id: current_user.id, 
				clase_id: clase,
				aprobada: false,
				asistencias: 0,
				faltas: 0
			)

			tomo_clase.save

			crear_nota_reference(periodo_id, tomo_clase.id, Constants::EDUCA_PARCIAL1)
			crear_nota_reference(periodo_id, tomo_clase.id, Constants::EDUCA_PARCIAL2)
			crear_nota_reference(periodo_id, tomo_clase.id, Constants::EDUCA_PARCIAL3)
			crear_nota_reference(periodo_id, tomo_clase.id, Constants::EDUCA_FINAL)
		end

		session.delete(:inscripciones)

		render json: { "ok" => true, "msg" => "" }
	end

	def horarios_show
		@periodos = Periodo.all
	end

	def horario_show
		@tomo_clases = TomoClase.where(alumno_id: current_user.id, clase_id: Clase.select(:id).where(periodo_id: params[:id]).all).all
	end

	def horario_asistencia
		asistencias = TomoClase.select(:asistencias, :faltas).where(alumno_id: params[:alumno_id], clase_id: params[:clase_id]).first

		render json: { "ok" => true, "asistencias" => asistencias.asistencias, "faltas" => asistencias.faltas }
	end

	private
		def crear_nota_reference(periodo_id, tomo_clase_id, estatus)
			nota = Calificacion.new(habilitar: false, codigo: estatus, periodo_id: periodo_id, tomo_clase_id: tomo_clase_id)
			nota.save
			nota.id
		end
end

