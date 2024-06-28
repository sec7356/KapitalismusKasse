//Autor: @Can

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
    popup.style.display = "block"; // Sicherstellen, dass das Popup angezeigt wird
    // Kurze Verzögerung hinzufügen, um sicherzustellen, dass die Anzeige ändert, bevor die Animation beginnt
    setTimeout(function() {
        popup.classList.add("show");
    }, 10);
}

// JavaScript-Funktion, um die Popup-Nachricht auszublenden
function hidePopup() {
    var popup = document.getElementById("popup");
    popup.classList.remove("show");
    // Füge eine Verzögerung hinzu, um sicherzustellen, dass die Animation beendet ist, bevor das Popup ausgeblendet wird
    setTimeout(function() {
        popup.style.display = "none";
    }, 200);
}

// Event-Listener für das Ausblenden des Popups, wenn der Benutzer auf "Verstanden" klickt
document.addEventListener("DOMContentLoaded", function () {
    var popupButton = document.querySelector('.popup-button');
    popupButton.addEventListener("click", function () {
        hidePopup();
    });

    // Überprüfe die versteckten Felder beim Laden der Seite
    var showMessage = getHiddenFieldValue("showMessage");
    var errorMessage = getHiddenFieldValue("errorMessage");
    var successMessage = getHiddenFieldValue("successMessage");

    if (showMessage === "true") {
        if (errorMessage) {
            showPopup(errorMessage);
        } else if (successMessage) {
            showPopup(successMessage);
        }
    }
});
