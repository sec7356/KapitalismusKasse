//Autor: @Can
"use strict";


function confirmDelete() {
    if (confirm("Sind Sie sich sicher, dass Sie den Account löschen möchten?\nSie landen danach wieder auf der Admin-Konsole")) {
        document.getElementById('deleteForm').submit();
    } else {
        // nichts tun
    }
}
