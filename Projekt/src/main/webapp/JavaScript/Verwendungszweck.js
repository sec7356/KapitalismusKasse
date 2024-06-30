//Autor: @Can
"use strict";

window.onload = function() {

document.getElementById("resetZeichen").addEventListener("click", resetForm);

function resetForm() {
    // Zurücksetzen des Eingabefelds
    document.getElementById("verwendungszweck").value = "";
    // Manuelle Aktualisierung des Zeichenzählers
    updateCharCount();
}};

function updateCharCount() {
    var maxLength = 140;
    var currentLength = document.getElementById("verwendungszweck").value.length;
    var remaining = maxLength - currentLength;
    var charCountElement = document.getElementById("char-count");

    if (remaining >= 0) {
        charCountElement.textContent = "Sie können noch " + remaining + " Zeichen eingeben.";
    } else {
        charCountElement.textContent = "Maximale Zeichenanzahl überschritten!";
    }
}


