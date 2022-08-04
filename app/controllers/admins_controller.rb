#Clase para login y creación de nuevos administradores
class AdminsController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Si ya estás autenticado, entonces no puedes acceder al login page
	before_action :redirect_if_authenticated, only: [:admin_login, :admin_post_login]

	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:new, :create, :administration, :edit, :update] 

	def administration

	end

	#Retornamos view para crear un nuevo admin
	def new
		@user = Admin.new
	end

	#Recibimos el post de 'new'
	def create
		params[:admin][:rol] = 3
		params[:admin][:confirmed_at] = Time.current
		ret = authcon_new_user(
			:user_class => Admin, 
			:required_params => create_admin_params, 
			:redirect_path => admin_administration_new_path
			)

		if ret
			flash[:notice] = "Admin creado"
		end
	end

	def edit

	end

	#Recibe el post proveniente de edit
	def update
		@user_updated = Admin.find(params[:admin][:admin_id])

		if params[:admin][:delete] == "1"
    		if current_user.id == @user_updated.id
    			destroy
    		else
    			redirect_to admin_administration_edit_path, notice: 'Admin eliminado'
    		end

    		@user_updated.destroy
    	else
			if @user_updated.update(update_admin_params) #Si no hubo error en la actulización...
				redirect_to admin_administration_edit_path, notice: 'Actualizado'
			else
				@user = Admin.new
				render :new, status: :unprocessable_entity
			end
		end
	end

	#Retornamos el view para login
	def admin_login

	end

	#Recibimos el post de 'admin_login'
	def admin_post_login
		if authcon_login(Admin, "/admin", "Solicita tu alta con administración") == false
			flash.now[:alert] = "Email o password incorrecto"
			render "admins/admin_login", status: :unprocessable_entity
		end
	end

	def destroy
		forget(current_user)

		logout
		redirect_to admin_path, notice: "Signed out"
	end

	private
		def create_admin_params
			params.require(:admin).permit(:email, :password, :password_confirmation, :rol, :confirmed_at)
		end

		def update_admin_params
			params.require(:admin).permit(:password, :password_confirmation)
		end
end
