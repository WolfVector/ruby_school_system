class PeriodosController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si ya estás autenticado, entonces no puedes acceder al login page
	before_action :redirect_if_authenticated, only: [:admin_login, :admin_post_login]

	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]

	def index
		@periodos = Periodo.all
	end

	def new
		@periodo = Periodo.new
	end

	def create
		@periodo = Periodo.new(create_periodo_params)

		if @periodo.save
			redirect_to new_periodo_path, notice: "Periodo creado"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
		@periodo = Periodo.find(params[:id])
	end

	def update
		@periodo = Periodo.find(params[:id])
		if @periodo.update(update_periodo_params)
			redirect_to edit_periodo_path, notice: "Periodo actualizado"
		else
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		periodo = Periodo.find(params[:id])
		state = false
		msg = 'Hubo un error al eliminar la periodo'

		if Periodo.destroy
			state = true
			msg = ''
		end

		render json: {"ok" => state, "msg" => msg}
	end

	private
		def create_periodo_params
			params.require(:periodo).permit(:periodo, :habilitar)
		end

		def update_periodo_params
			params.require(:periodo).permit(:periodo, :habilitar)
		end
end
