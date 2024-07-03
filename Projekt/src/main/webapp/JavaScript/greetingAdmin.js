//Autor: @Can

"use strict"

document.addEventListener('DOMContentLoaded', function() {
function BegruessungAdmin() {
    var jetzt = new Date();
    var stunde = jetzt.getHours();
    var begruessung;

    if (stunde < 12) {
        begruessung = "Guten Morgen";
    } 
    else if (stunde < 17) {
        begruessung = "Guten Mittag";
    } 
    else {
        begruessung = "Guten Abend";
    }
    document.getElementById('greeting').textContent = begruessung + ", " + "Admin" + " 👋";
}

// Begrüßung bei Seitenladen einstellen
window.onload = BegruessungAdmin;
});





