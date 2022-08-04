Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #root 'static_pages#home'
  mount Auth::Engine, at: '/auth'
  
  #Crear y editar administradores
  get "admin/administration", to: "admins#administration"
  post "admin/administration/new", to: "admins#create" 
  get "admin/administration/new", to: "admins#new"
  get "admin/administration/edit", to: "admins#edit"
  put "admin/administration/edit", to: "admins#update"
  #delete "admin/administration", to: "admins#delete"

  #Crear y editar maestros
  resources :maestros
  resources :asignaturas
  resources :clases
  resources :periodos
  resources :carreras

  delete "horarios/:id", to: "horarios#destroy"

  get "inscripcion", to: "inscripciones#index_periodo"
  get "inscripcion/agregar/:id", to: "inscripciones#index"
  post "inscripcion/agregar", to: "inscripciones#agregar"
  post "inscripcion/cancelar", to: "inscripciones#cancelar"
  get "inscripcion/carrito/:id", to: "inscripciones#carrito"
  post "inscripcion/carrito", to: "inscripciones#create"
  get "horario/periodo", to: "inscripciones#horarios_show"
  get "horario/periodo/:id", to: "inscripciones#horario_show" 
  get "horario/asistencia/:clase_id/:alumno_id", to: "inscripciones#horario_asistencia" 

  get "calificaciones/periodo", to: "calificaciones#calif_periodo"
  get "calificaciones/alumno/:id", to: "calificacion_alumnos#index"
  get "calificaciones/ver/alumno/:id", to: "calificacion_alumnos#show"
  get "calificaciones/maestro/:id", to: "calificacion_maestros#index"
  get "calificaciones/ver/clase/:id", to: "calificacion_maestros#show_all"
  get "calificaciones/agregar/alumno/:id", to: "calificacion_maestros#nota_new"
  post "calificaciones/agregar/alumno", to: "calificacion_maestros#nota_add"

  #get "periodos", to: "clases#show_periodos"

  #Login y logout 
  post "admin", to: "admins#admin_post_login"
  get "admin/logout", to: "admins#destroy"
  get "admin", to: "admins#admin_login"
end
