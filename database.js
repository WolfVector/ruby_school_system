users (alumnos) {
	datos alumno
}

maestros {
	datos maestro
}

admins {
	datos admin
}

materias {
	id
	materia
	id_seriada //id que almacena la materia que se tiene que cursar antes
}

periodos {
	id
	periodo
	habilitar
}

carreras {
	id
	carrera
}

clases {
	id
	id_materia
	id_periodo
	id_carrera
	cupo
	grupo
	id_maestro
}

//La clase con el mismo grupo se puede dar en distintos dias y horas
//Por ejemplo: Lunes, 13:00-14:00. Martes, 13:00-15:00
//Por lo tanto, para un grupo pueden existir varios registros 
horarios {
	id
	id_clase
	hora
	dia
}

tomo_clases {
	id
	id_user //Alumno
	id_clase
	asistencias
	primer_parcial
	segundo_parcial
	tercer_parcial
	examen_final
	extraordinario
	regulacion
	habilitar //Si es TRUE, entonces los maestros pueden subir calificaciones
}


/*
El maestro tendrá has_many :clases, y Clase tiene has_many :alumnos, class_name: "TomoClase", por lo tanto, 
el docente podrá modificar asistencias, primer_parcial, segundo_parcial, tercer_parcial, examen_final, extraordinario y regulacion

Para visualizarlo
@maestro.clases.alumnos.each do |alumno|
	alumno.auth_user.full_name
	alumno.asistencias
	alumno.primer_parcial
	alumno.segundo_parcial
	.
	.
	.
	alumno.regulacion
end

Para guardar calificiones
alumno = TomoClase.fin(id)
alumno.update(primer_parcial, segundo_parcial, tercer_parcial)
*/

/*
El campo habilitar permitiría modificar cualquier parcial o examen. Si se desea habilitar sólo uno de ellos se podría adoptar
por agregar un "habilitar" para cada examen. Esto, a mi parecer, sería un mal diseño. Considero que algo mejor sería
lo siguiente.
*/

tomo_clases {
	id
	id_user //Alumno
	id_clase
	aprobada  //Este campo se modificará en el final, extra o regu
	asistencias
	faltas
}

examenes {
	id
	id_tomo_clase
	id_periodo
	calificacion
	habilitar
	codigo     //Esto hará referencia a si se trata del primer parcial, 2do. parcial, 3er. parcial, etc.
}

/*
De esta forma haciendo uso de "codigo" el administrador podría habilitar las entradas sólo para un parcial o examen 
en específico. Con id_periodo habilitamos sólo aquellos al periodo actual, además, también sirve para obtener 
estadísticas.
*/