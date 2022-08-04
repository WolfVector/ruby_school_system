async function EDUCA_fetch(url, object) {
    /**
     * Se utiliza fetch para la creación de peticiones por el hecho de que es nativa y no requiere librerías externas.
     * Si fetch retorna false, entonces hay un error en el servidor:
     * cualquier error relacionado a ruby como de sintaxis, array fuera del límite, función o variable no existe, etc.
     * cualquier error relacionado a sql 
     * Cualquier otro error del servidor.
     * 
     * En caso de que no haya error, entonces retorna el objeto json, es decir, la respuesta.
     */
    let response = await fetch(url, object);
    return ((!response.ok) ? false : await response.json());
}

function EDUCA_req_delete(url, callback) {
    Swal.fire({
        title: '¿Estás seguro?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Eliminar',
        showLoaderOnConfirm: true,
        preConfirm: async () => {
            var ret = await EDUCA_fetch(url,{
                method: 'DELETE',
                headers: {
                    'x-csrf-token': EDUCA_csrf()
                } 
            });

            if(ret === false) Swal.showValidationMessage('Hubo un error en el servidor');
            else if(ret.ok) {
                callback();
                EDUCA_show_msg('Listo', 'success');
            }
            else EDUCA_show_msg('Error', ret.msg);
        },
        allowOutsideClick: () => !Swal.isLoading()
    });
}

function EDUCA_csrf() {
    const metaCsrf = document.querySelector("meta[name='csrf-token']");
    return metaCsrf.getAttribute('content'); 
}

async function EDUCA_clase_asistencia(self, alumno_id,clase_id) {
        var ret = await EDUCA_fetch("/horario/asistencia/"+clase_id+"/"+alumno_id,{
            method: 'GET',
            headers: {
                'x-csrf-token': EDUCA_csrf(),
                "Content-Type": "application/json",
                "Accept": "application/json"
            } 
        }); 

        if(ret === false) 
            EDUCA_default_top_msg("Hubo un error en el servidor", "error");
        else if (ret.ok == false) 
            EDUCA_default_top_msg(ret.msg, "error");
        else {
            Swal.fire({
                title: 'Asistencias',
                html:
                    `
                    <table class='table table-striped'>
                        <thead>
                            <tr>
                                <th>Campo</th>
                                <th>Valor</th>
                            </tr>
                        <thead>
                        <tbody>
                            <tr>
                                <td>Asistencias:</td>
                                <td>${ret.asistencias}</td>
                            </tr>
                            <tr>
                                <td>Faltas:</td>
                                <td>${ret.faltas}</td>
                            </tr>
                        </tbody>
                    <table>
                    `,
                showCloseButton: true,
            });
        }   
    }

window.EDUCA_fetch = EDUCA_fetch;
window.EDUCA_req_delete = EDUCA_req_delete;
window.EDUCA_csrf = EDUCA_csrf;
window.EDUCA_clase_asistencia = EDUCA_clase_asistencia;
