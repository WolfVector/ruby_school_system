module AuthenticationCurrent
	def current_user
		user_class = Auth::User

		if session[:current_user_id].present?
			if session[:rol] == 2
				user_class = Maestro
			elsif session[:rol] == 3
				user_class = Admin
			end

			#Obtén el usuario a través de la sesión o el token de recuerdame
			Auth::Current.user ||= if session[:current_user_id].present? 
				user_class.find_by(id: session[:current_user_id])
			elsif cookies.permanent.encrypted[:remember_token].present?
				user_class.find_by(remember_token: cookies.permanent.encrypted[:remember_token])
			end
		end
	end	
end