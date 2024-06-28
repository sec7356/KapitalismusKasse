//Autor: @Can

"use strict";

// Funktion zur Bestimmung der Begrüßung basierend auf der Tageszeit
function Begruessung() {
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
    
    var vorname = document.getElementById('vorname').textContent;
    var nachname = document.getElementById('nachname').textContent;
    document.getElementById('greeting').textContent = begruessung + ", " + vorname + " " + nachname + " 👋";
}
// Begrüßung bei Seitenladen einstellen
window.onload = Begruessung;




