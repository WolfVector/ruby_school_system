Auth::StaticPagesController.class_eval do
	#Si el usuario no ha iniciado sesión, no permitas que entre a 'home'
	before_action :authenticate_user!, only: [:home]
end