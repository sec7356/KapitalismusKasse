//Autor: Can - Code von mir, ChatGPT zur Korrektur

"use strict";

window.onload = function() {
    // Event-Handler für das Zurücksetzen des Formulars
    document.getElementById("resetZeichen").addEventListener("click", resetForm);

    // Event-Handler für die Eingabe im Textfeld
    document.getElementById('verwendungszweck').addEventListener('input', function() {
        updateCharCount(); // Rufe die Funktion auf, um die Zeichenzählung zu aktualisieren
    });
};

// Funktion zum Zurücksetzen des Formulars
function resetForm() {
    // Zurücksetzen des Eingabefelds
    document.getElementById("verwendungszweck").value = "";
    // Manuelle Aktualisierung des Zeichenzählers
    updateCharCount();
}

// Funktion zur Aktualisierung der Zeichenzählung
function updateCharCount() {
    var maxLength = 140; // Maximale Anzahl erlaubter Zeichen
    var currentLength = document.getElementById('verwendungszweck').value.length; // Aktuelle Anzahl der Zeichen im Textfeld
    var remaining = maxLength - currentLength; // Berechne verbleibende Zeichen

    // Text für das Zeichenlimit aktualisieren
    var charCountElement = document.getElementById('char-count');
    if (remaining >= 0) {
        charCountElement.textContent = 'Sie können noch ' + remaining + ' Zeichen eingeben.';
    } else {
        charCountElement.textContent = 'Maximale Zeichenanzahl erreicht.';
    }
}
