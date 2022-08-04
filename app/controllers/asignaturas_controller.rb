class AsignaturasController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si ya estás autenticado, entonces no puedes acceder al login page
	before_action :redirect_if_authenticated, only: [:admin_login, :admin_post_login]

	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]

	def index
		@asignaturas = Asignatura.all
	end

	def new
		@asignatura = Asignatura.new
	end

	def create
		@asignatura = Asignatura.new(create_asignatura_params)

		if @asignatura.save
			redirect_to new_asignatura_path, notice: "Asignatura creada"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@asignatura = Asignatura.find(params[:id])
	end

	def update
		@asignatura = Asignatura.find(params[:id])
	
		if @asignatura.update(update_asignatura_params)
			redirect_to edit_asignatura_path, notice: "Asignatura actualizada"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		asignatura = Asignatura.find(params[:id])
		state = false
		msg = 'Hubo un error al eliminar la asignatura'

		if asignatura.destroy
			state = true
			msg = ''
		end

		render json: {"ok" => state, "msg" => msg}
	end

	private
		def create_asignatura_params
			params.require(:asignatura).permit(:asignatura, :seriada_id)
		end

		def update_asignatura_params
			params.require(:asignatura).permit(:asignatura, :seriada_id)
		end
end
