class ClasesController < ApplicationController
	include AuthenticationOverride, UserConcern

	#Sólo puedes acceder a esta url si has iniciado sesión
	before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]

	#Muestra clases del periodo seleccionado
	def index
		@clases = Clase.all
	end

	def new
		@clase = Clase.new
	end

	def create
		@clase = Clase.new(create_clase_params)

		if !@clase.save
			render :new, status: :unprocessable_entity
			return
		end

		fin = params[:clase][:fin]
		dia = params[:clase][:dia]

		params[:clase][:hora].each_with_index do |element, i|
		horario = Horario.new(clase_id: @clase.id, hora: element, fin: fin[i], dia: dia[i])

			if !horario.save
				flash.now[:alert] = "Hubo un error al guardar el horario."
				render :new, status: :unprocessable_entity

				return
			end
		end

		
		redirect_to new_clase_path, notice: "Clase creada"
	end

	def edit
		@clase = Clase.find(params[:id])
	end

	def update
		@clase = Clase.find(params[:id])
		if !@clase.update(update_clase_params)
			render :new, status: :unprocessable_entity
			return
		end

		hora = params[:clase][:hora]
		fin = params[:clase][:fin]
		dia = params[:clase][:dia]

		params[:clase][:horario_ids].each_with_index do |id, i|
			horario = Horario.find(id);

			if !horario.update(hora: hora[i], fin: fin[i], dia: dia[i])
				flash.now[:alert] = "Hubo un error al actualizar el horario."
				render :new, status: :unprocessable_entity

				return
			end
		end

		redirect_to edit_clase_path, notice: "Clase actualizada"
	end

	def destroy
		clase = Clase.find(params[:id])
		state = false
		msg = 'Hubo un error al eliminar la clase'

		if clase.destroy
			state = true
			msg = ''
		end

		render json: {"ok" => state, "msg" => msg}
	end

	private
		def create_clase_params
			params.require(:clase).permit(:maestro_id, :asignatura_id, :periodo_id, :carrera_id, :grupo, :cupo)
		end

		def update_clase_params
			params.require(:clase).permit(:maestro_id, :asignatura_id, :periodo_id, :carrera_id, :grupo, :cupo)
		end
end
