//Autor: Diane - Grundidee und Hauptteil des Code von mir, ChatGPT zur korrekten & effizienteren Umsetzung

"use strict";

// Funktion zum Abrufen von Werten aus versteckten HTML-Feldern
function getHiddenFieldValue(id) {
    var element = document.getElementById(id);
    return element ? element.value : null;
}

// JavaScript-Funktion, um die Popup-Nachricht anzuzeigen
function showPopup(message) {
    var popup = document.getElementById("popup");
    var popupMessage = document.getElementById("popupMessage");
    popupMessage.innerHTML = message;
    popup.style.display = "block";
}

//document.getElementById("bestaetigen").addEventListener("click", hidePopup);
	var bestaetigen = document.getElementById("bestaetigen");
	if (bestaetigen) {
		bestaetigen.addEventListener("click", function() {
			hidePopup();
	});
};
	

// JavaScript-Funktion, um die Popup-Nachricht auszublenden
function hidePopup() {
    var popup = document.getElementById("popup");
    popup.style.display = "none";
}

// Event-Listener für das Ausblenden des Popups, wenn der Benutzer auf "Verstanden" klickt
document.addEventListener("DOMContentLoaded", function () {
    var popupButton = document.querySelector('.popup-button');
    if (popupButton) {
        popupButton.addEventListener("click", function () {
            hidePopup();
        });
    }

    // Überprüfe die versteckten Felder beim Laden der Seite
    var showMessage = getHiddenFieldValue("showMessage");
    var successMessage = getHiddenFieldValue("successMessage");
    if (showMessage === "true" && successMessage) {
        showPopup(successMessage);
    }
});
