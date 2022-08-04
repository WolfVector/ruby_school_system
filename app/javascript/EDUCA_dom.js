function new_horario_field() {
	var horario_div = document.getElementById('horario_div');

	var div_parent = document.createElement	('div'); //Para poder eliminar los fields
	var hora = document.createElement('div');
	var fin = document.createElement('div');
	var dia = document.createElement('div');

	var hora_label = document.createElement('label');
	var fin_label = document.createElement('label');
		
	var eliminar_div = document.createElement('div');
	var eliminar = document.createElement('button');

	div_parent.setAttribute('class', 'mt-5 row');

	eliminar_div.setAttribute('class', 'mt-5 form-input col-md-2')

	eliminar.setAttribute('type', 'button');
	eliminar.setAttribute('class', 'btn-sm btn-danger')
	eliminar.innerHTML = 'Eliminar'
	eliminar.addEventListener('click', function() {
		this.parentElement.parentElement.remove();
	});

	eliminar_div.appendChild(eliminar);

	dia.setAttribute('class', 'mt-5 form-input col-md-2');
	hora.setAttribute('class', 'mt-3 form-input col-md-2');
	fin.setAttribute('class', 'mt-3 form-input col-md-2')

	hora_label.setAttribute('class', 'form-label');
	hora_label.innerHTML = 'Inicio';
	hora_field = document.createElement('input');
	hora_field.setAttribute('type', 'time');
	hora_field.setAttribute('name', 'clase[hora][]');
	hora_field.setAttribute('class', 'form-control form-control-focus form-control-sm text-white bg-dark');

	fin_label.setAttribute('class', 'form-label');
	fin_label.innerHTML = 'Fin';
	fin_field = document.createElement('input');
	fin_field.setAttribute('type', 'time');
	fin_field.setAttribute('name', 'clase[fin][]');
	fin_field.setAttribute('class', 'form-control form-control-focus form-control-sm text-white bg-dark');

	dia_field = document.createElement('select');
	dia_field.setAttribute('name', 'clase[dia][]');
	dia_field.setAttribute('class', 'form-select text-white bg-dark form-control-sm form-no-radius form-control-focus');
		
	dia_field.appendChild(new_select_option("", "Seleccionar día", true));
	dia_field.appendChild(new_select_option("Lunes", "Lunes"));
	dia_field.appendChild(new_select_option("Martes", "Martes"));
	dia_field.appendChild(new_select_option("Miércoles", "Miércoles"));
	dia_field.appendChild(new_select_option("Jueves", "Jueves"));
	dia_field.appendChild(new_select_option("Viernes", "Viernes"));

	hora.appendChild(hora_label);
	hora.appendChild(hora_field);
	fin.appendChild(fin_label);
	fin.appendChild(fin_field)
	dia.appendChild(dia_field)

	div_parent.appendChild(dia);
	div_parent.appendChild(hora);		
	div_parent.appendChild(fin);
	div_parent.appendChild(eliminar_div);

	horario_div.appendChild(div_parent)
}

function new_select_option(value, text, selected = false) {
	var option = document.createElement('option');
	option.text = text;
	option.value = value;
	option.selected = selected;

	return option;
}

window.new_horario_field = new_horario_field;
window.new_select_option = new_select_option;