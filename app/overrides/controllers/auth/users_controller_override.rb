Auth::UsersController.class_eval do
	#Si el usuario no ha iniciado sesión, no permitas que entre a 'edit', 'destroy' y 'update'
	#before_action :authenticate_user!, only: [:inscripcion_index]

	def create
		params[:user][:rol] = 1
		 if authcon_new_user(:user_class => Auth::User, :required_params => create_user_params)
		 	flash[:notice] = "Revisaba tu correo y sigue las instrucciones de confirmación"
		 end
	end

	#def inscripcion_index
	#	render "inscripciones/index"
	#end

	private
	def create_user_params
		params.require(:user).permit(:email, :matricula, :nombre, :apaterno, :amaterno, :password, :password_confirmation, :rol)
	end

	def update_user_params
		params.require(:user).permit(:current_password, :password, :password_confirmation, :unconfirmed_email)
	end
end