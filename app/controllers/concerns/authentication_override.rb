module AuthenticationOverride
	extend ActiveSupport::Concern

	include Authentication
	prepend AuthenticationCurrent

	#Login
	def login(user)
		reset_session #Evitamos session fixation
		session[:current_user_id] = user.id #Almacenamos el user id en el session storage
		session[:rol] = user.rol
	end

	private 

	#Obtenemos el usuario que está haciendo el request y lo almacenamos en su thread

	def authenticate_user!
		redirect_to '/auth/login', alert: "Yo need to login to access that page" unless session[:current_user_id].present? && session[:rol] == 3
	end
end