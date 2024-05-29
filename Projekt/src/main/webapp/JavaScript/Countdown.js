"use strict";

// Variable zur Speicherung der Timer-ID
var timerId;

// Funktion zum Starten des Timers
function startTimer() {
    var timer = document.getElementById('timer');
    var timeArray = timer.textContent.split(":");
    var minuten = parseInt(timeArray[0]);
    var sekunden = parseInt(timeArray[1]);

    // Überprüfen, ob der Timer auf null ist
    if (minuten === 0 && sekunden === 0) {
        console.log("Logout ausgelöst!");
        alert("Sie wurden aus Sicherheitsgründen abgemeldet!");
        window.location.href = logoutUrl;  // logoutUrl ist eine globale Variable, die die Logout-URL speichert
        return;
    }

    sekunden--;
    if (sekunden < 0) {
        minuten--;
        sekunden = 59;
    }

    // Aktualisieren der Timer-Anzeige ohne führende Nullen für Minuten
    timer.textContent = minuten + ":" + sekunden.toString().padStart(2, "0");

    // Speichern der verbleibenden Zeit in localStorage
    localStorage.setItem('remainingTime', timer.textContent);

    // Planen des nächsten Timer-Updates
    timerId = setTimeout(startTimer, 1000); // Test --> 1000 für 1 Sekunde
}

// Funktion zum Zurücksetzen des Timers bei Benutzerinteraktion
function resetTimer() {
    // Den bestehenden Timer löschen
    clearTimeout(timerId);

    // Den Timer auf 5 Minuten zurücksetzen
    document.getElementById('timer').textContent = "5:00";

    // Speichern der neuen verbleibenden Zeit in localStorage
    localStorage.setItem('remainingTime', "5:00");

    // Den Timer erneut starten
    startTimer();
}

// Funktion zum Wiederherstellen des Timers aus localStorage
function restoreTimer() {
    var savedTime = localStorage.getItem('remainingTime');
    if (savedTime) {
        document.getElementById('timer').textContent = savedTime;
    } else {
        document.getElementById('timer').textContent = "5:00";
    }
}

// Ereignislistener für Benutzerinteraktionen hinzufügen (bei Bedarf anpassen)
document.addEventListener("mousemove", resetTimer);
document.addEventListener("keydown", resetTimer);
document.addEventListener("click", resetTimer);

// Den Timer anfangs wiederherstellen und starten
window.onload = function() {
    restoreTimer();
    startTimer();
};

// Globale Variable für die Logout-URL definieren
var logoutUrl = "/KapitalismusKasse_LOKAL/LogoutServlet";
