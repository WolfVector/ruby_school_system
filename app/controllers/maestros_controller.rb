class MaestrosController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si ya estás autenticado, entonces no puedes acceder al login page
	before_action :redirect_if_authenticated, only: [:admin_login, :admin_post_login]

	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]

	def index
		@maestros = Maestro.all
	end	

	def new
		@maestro = Maestro.new
	end

	def create
		params[:maestro][:rol] = 2;
		params[:maestro][:confirmed_at] = Time.current
		ret = authcon_new_user(
			:user_class => Maestro, 
			:required_params => create_maestro_params,
			:redirect_path => new_maestro_path
			)

		if ret
			flash[:notice] = "Maestro creado"
		end
	end

	def edit
		@maestro = Maestro.find(params[:id])
	end

	def update
		@maestro = Maestro.find(params[:id])
		ret = authcon_direct_update_user(
			:user_class => @maestro,
			:required_params => update_maestro_params,
			:redirect_path => edit_maestro_path,
			)

		if ret
			flash[:notice] = "Maestro actualizado"
		end
	end

	def destroy
		maestro = Maestro.find(params[:id])
		state = false
		msg = 'Hubo un error al eliminar el usuario'

		if maestro.destroy
			state = true
			msg = ''
		end

		render json: {"ok" => state, "msg" => msg} 
	end

	private
		def create_maestro_params
			params.require(:maestro).permit(:email, :nombre, :apaterno, :amaterno, :password, :password_confirmation, :rol, :confirmed_at)
		end

		def update_maestro_params
			params.require(:maestro).permit(:nombre, :apaterno, :amaterno, :apaterno, :password, :password_confirmation)
		end
end
