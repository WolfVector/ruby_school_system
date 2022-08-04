class HorariosController < ApplicationController
	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:destroy]

	def destroy
		horario = Horario.find(params[:id])
		state = false
		msg = 'Hubo un error al eliminar el horario'

		if horario.destroy
			state = true
			msg = ''
		end

		render json: {"ok" => state, "msg" => msg}
	end
end
