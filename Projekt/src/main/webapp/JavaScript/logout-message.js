//Autor: @Can

"use strict";

document.addEventListener("DOMContentLoaded", function() {
    // JavaScript-Funktion, um das Logout-Element nach einer bestimmten Zeit auszublenden
    function hideLogoutMessage() {
        var logoutMessageElement = document.getElementById("logout-message");
        if (logoutMessageElement) {
            logoutMessageElement.style.display = "none";
        }
    }

    // Versteckt die Logout-Meldung nach 5 Sekunden (5000 Millisekunden)
    setTimeout(hideLogoutMessage, 5000);
});
