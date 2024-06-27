"use strict";

// Event Listener für Änderungen an Kredithöhe und Laufzeit
document.getElementById("kredithoehe").addEventListener('input', updateMonatlicheRate);
document.getElementById("laufzeit").addEventListener('input', function() {
    document.getElementById("laufzeit-anzeige").innerHTML = document.getElementById("laufzeit").value + ' Monate';
    updateMonatlicheRate();
});

// Initial die monatliche Rate berechnen und anzeigen
updateMonatlicheRate();

// Funktion zur Berechnung der monatlichen Rate
function berechneMonatlicheRate(kredithoehe, laufzeit) {
    var zinssatz = 21.5; // Zinssatz in Prozent
    var monatlicherZinssatz = zinssatz / 100 / 12;
    var anzahlRaten = laufzeit;
    if (anzahlRaten === 0) {
        return kredithoehe;
    }
    var monatlicheRate = (kredithoehe * monatlicherZinssatz) / (1 - Math.pow(1 + monatlicherZinssatz, -anzahlRaten));
    return monatlicheRate;
}

// Funktion, um die Rate dynamisch zu aktualisieren
function updateMonatlicheRate() {
    var kredithoeheInput = document.getElementById("kredithoehe").value;
    var laufzeitInput = document.getElementById("laufzeit").value;
    
    var kredithoehe = parseFloat(kredithoeheInput);
    var laufzeit = parseInt(laufzeitInput);
    
    if (isNaN(kredithoehe) || isNaN(laufzeit)) {
        document.getElementById("rate-anzeige").innerHTML = '0.00€';
        return;
    }
    
    var monatlicheRate = berechneMonatlicheRate(kredithoehe, laufzeit);
    document.getElementById("rate-anzeige").innerHTML = monatlicheRate.toFixed(2) + '€';
}

