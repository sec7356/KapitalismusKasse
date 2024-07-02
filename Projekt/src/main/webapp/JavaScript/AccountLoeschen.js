//Autor: @Can, @Selim

"use strict";

document.addEventListener("DOMContentLoaded", function() {
    var deleteButton = document.getElementById("benutzerLoeschen");
    if (deleteButton) {
        deleteButton.addEventListener("click", function() {
            if (confirm("Sind Sie sich sicher, dass Sie den Account löschen möchten?\nSie landen danach wieder auf der Admin-Konsole")) {
                document.getElementById('deleteForm').submit();
            }
        });
    }
});