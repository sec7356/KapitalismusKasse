"use strict";

// Elemente aus dem DOM holen


// Event Listener für Änderungen an Kredithöhe und Laufzeit
document.getElementById("kredithoehe").addEventListener('keydown', updateMonatlicheRate);
document.getElementById("laufzeit").addEventListener('click', function() {
    document.getElementById("laufzeit-anzeige").innerHTML = document.getElementById("laufzeit").value + ' Monate';
    updateMonatlicheRate();
});

// Initial die monatliche Rate berechnen und anzeigen
updateMonatlicheRate();

// Funktion zur Berechnung der monatlichen Rate
function berechneMonatlicheRate(kredithoehe, laufzeit) {
    var zinssatz = 3.5; // Beispiel-Zinssatz in Prozent (hier festgelegt)
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
	var kredithoeheInput = document.getElementById("kredithoehe");
	var laufzeitInput = document.getElementById("laufzeit");
	
	var rateAnzeige = document.getElementById("rate-anzeige");
    var kredithoehe = parseFloat(kredithoeheInput.value);
    var laufzeit = parseInt(laufzeitInput.value);
    var monatlicheRate = berechneMonatlicheRate(kredithoehe, laufzeit);
    rateAnzeige.innerHTML = monatlicheRate.toFixed(2) + '€';
}
