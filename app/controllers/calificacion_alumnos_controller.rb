class CalificacionAlumnosController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si el usuario no ha iniciado sesión, no permitas que entre a:
	before_action :authenticate_alumno!, only: [:index]
	before_action :authenticate_alum_maestro!, only: [:show]

	helper_method :calificacion_total

	def authenticate_alumno!
		redirect_to '/auth', alert: "Es necesario que inicies sesión" unless session[:current_user_id].present? && session[:rol] == 1
	end

	def authenticate_alum_maestro!
		redirect_to '/auth', alert: "Es necesario que inicies sesión" unless session[:current_user_id].present? && (session[:rol] == 1 || session[:rol] == 2)
	end

	def index
		@tomo_clases = TomoClase.where(alumno_id: current_user.id, clase_id: Clase.select(:id).where(periodo_id: params[:id]).all).all
	end

	def show
		@tomo_clase = TomoClase.find(params[:id])
	end

	def self.calificacion_total(parcial1, parcial2, parcial3, final)
		(((parcial1 + parcial2 + parcial3) / 3) * 0.60) + 0.4*final
	end
end
