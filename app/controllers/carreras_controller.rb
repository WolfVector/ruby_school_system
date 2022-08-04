class CarrerasController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si ya estás autenticado, entonces no puedes acceder al login page
	before_action :redirect_if_authenticated, only: [:admin_login, :admin_post_login]

	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]

	def index
		@carreras = Carrera.all
	end

	def new
		@carrera = Carrera.new
	end

	def create
		@carrera = Carrera.new(create_carrera_params)

		if @carrera.save
			redirect_to new_carrera_path, notice: "Carrera creada"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@carrera = Carrera.find(params[:id])
	end

	def update
		@carrera = Carrera.find(params[:id])
	
		if @carrera.update(update_carrera_params)
			redirect_to edit_carrera_path, notice: "Carrera actualizada"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		carrera = Carrera.find(params[:id])
		state = false
		msg = 'Hubo un error al eliminar la carrera'

		if carrera.destroy
			state = true
			msg = ''
		end

		render json: {"ok" => state, "msg" => msg}
	end

	private
		def create_carrera_params
			params.require(:carrera).permit(:carrera)
		end

		def update_carrera_params
			params.require(:carrera).permit(:carrera)
		end
end
