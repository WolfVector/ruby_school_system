class CalificacionesController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si el usuario no ha iniciado sesión, no permitas que entre a:
	before_action :authenticate_user!, only: [:calif_periodo, :calif_alumno, :calif_maestro]

	#Hay dos formas de resolver el problema, una es verificando las urls y el rol para permitir o no 
	#la entrada. La otra opción es realizar dos controladores. Uno para el maestro y otro para el alumno.
	#Tal vez opte por esta última, es más fácil y el código de ambos se encontraría separado
	#Sin embargo, dejaré esto aquí para tenerlo como ejemplo en caso de que sea necesario.

	@@all_urls = [
		'/calificaciones/periodo'
	]

	@@alumno_urls = [
		'/calificaciones/alumno'
	]

	@@maestro_urls = [
		'/calificaciones/maestro'
	]

	def authenticate_user!
		if !request.local? || !allow_user?(request.path)
			redirect_to '/auth'
		end
	end

	def authenticate_alumno!
		redirect_to '/auth/login', alert: "Es necesario que inicies sesión" unless session[:current_user_id].present? && session[:rol] == 1
	end

	def calif_periodo
		@periodos = Periodo.all
	end

	def calif_alumno

	end

	def calif_maestro

	end

	private
		def allow_user?(url)
			rol = current_user.rol

			#if params[:id].nil?
			#	return false

			if rol == 3
				false
			elsif @@all_urls.include?(url)
				true
			elsif rol == 1 && @@maestro_urls.include?(url)
				false
			elsif rol == 2 && @@alumno_urls.include?(url)
				false
			else
				true
			end
		end
		
end
