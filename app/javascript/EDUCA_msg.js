const EDUCA_ONE_MINUTE = 1000;
const EDUCA_ONE_HALF_MINUTE = 1500;

function EDUCA_show_msg(title, icon) {
    Swal.fire({
        title,
        icon
    });
}

function EDUCA_show_top_msg(title, icon, timer) {
    Swal.fire({
        position: 'top-end',
        icon,
        title,
        showConfirmButton: false,
        timer
    });
}

function EDUCA_default_top_msg(title, icon) {
    EDUCA_show_top_msg(title, icon, EDUCA_ONE_MINUTE);
}

window.EDUCA_show_msg = EDUCA_show_msg;
window.EDUCA_show_top_msg = EDUCA_show_top_msg;
window.EDUCA_default_top_msg = EDUCA_default_top_msg;

window.EDUCA_ONE_MINUTE = EDUCA_ONE_MINUTE;
window.EDUCA_ONE_HALF_MINUTE = EDUCA_ONE_HALF_MINUTE;
