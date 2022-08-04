Auth::SessionsController.class_eval do
	def create
		if authcon_login(Auth::User, "/auth/confirmations/new") == false
			if authcon_login(Maestro, "/auth/login", "Solicita tu alta con administración") == false
				flash.now[:alert] = "Email o password incorrecto"
				render "auth/sessions/new", status: :unprocessable_entity
			end
		end
		#ret = authcon_login(Auth::User, "/auth/confirmations/new")
		#if ret[:status] == false
		#	ret = authcon_login(Maestro, "/auth/login", "Solicita tu alta con administración")
		#	if ret[:status] == false
	#	#		logger.debug 'hhhhh'
		#		@user = ret[:user]
		#		flash.now[:alert] = "Email o password incorrecto"
		#		render "auth/sessions/new", status: :unprocessable_entity
		#	end
		#end

	#	@user = ret[:user]
	end
end