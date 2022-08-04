Auth::ApplicationController.class_eval do
	prepend AuthenticationCurrent

	def login(user)
		reset_session #Evitamos session fixation
		session[:current_user_id] = user.id #Almacenamos el user id en el session storage
		session[:rol] = user.rol
	end

	#def current_user
	#	user_class = Auth::User

	#	if session[:current_user_id].present?
	#		if session[:rol] == 2
	#			user_class = Maestro
	#		elsif session[:rol] == 3
				user_class = Admin
	#		end

	#		Auth::Current.user ||= if session[:current_user_id].present? 
	#	      user_class.find_by(id: session[:current_user_id])
	#	    elsif cookies.permanent.encrypted[:remember_token].present?
	#	      user_class.find_by(remember_token: cookies.permanent.encrypted[:remember_token])
	#	    end
	#	end
	#end

	#def authenticate_user!
	#	store_location #Guarda la url protegida que el user intentó acceder
		
	#	if user_signed_in? && current_user.rol != 3
	#		if request.local? && request.original
	#	end

		#Redirecciona a login page
	#	redirect_to login_path, alert: "Yo need to login to access that page" unless user_signed_in?
	#end
end