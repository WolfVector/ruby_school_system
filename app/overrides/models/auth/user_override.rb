Auth::User.class_eval do
	has_many :clase, class_name: "TomoClase", foreign_key: "alumno_id"

	validates :matricula, 
		presence: {message: "El campo matrícula es requerido" }, 
		uniqueness: {
			message: ->(object, data) do 
				"#{object.name}, #{data[:value]} ya existe."
			end
			}, 
		length: {is: 6, message: "La longitud debe ser de 6 números"}, 
		numericality: { only_integer: true, message: "La matrícula sólo debe estar compuesta por numeros" }
	
	validates :nombre, 
		presence: { message: "El nombre es requerido" },
		format: { with: /\A[a-zA-Z]+\z/, message: "El nombre sólo debe incluir letras" }  

	validates :apaterno, 
		presence: { message: "El apellido paterno es requerido" },
		format: { with: /\A[a-zA-Z]+\z/, message: "El nombre sólo debe incluir letras" }  

	validates :amaterno, 
		presence: { message: "El apellido materno es requerido" },
		format: { with: /\A[a-zA-Z]+\z/, message: "El nombre sólo debe incluir letras" }

	def full_name
		"#{apaterno} #{amaterno} #{nombre}"
	end  
end