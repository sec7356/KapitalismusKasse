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

// JavaScript-Funktion, um die Popup-Nachricht auszublenden
function hidePopup() {
    var popup = document.getElementById("popup");
    popup.style.display = "none";
}

// Event-Listener für das Ausblenden des Popups, wenn der Benutzer auf "Verstanden" klickt
document.addEventListener("DOMContentLoaded", function () {
    var showMessage = getHiddenFieldValue("showMessage");
    var errorMessage = getHiddenFieldValue("errorMessage");
    if (showMessage === "true" && errorMessage) {
        showPopup(errorMessage);
        popupMode = true;
    }

    var popupButton = document.querySelector('.popup-button');
    popupButton.addEventListener("click", function () {
        if (popupMode) {
            hidePopup();
            popupMode = false;
        }
    });
});

// Globale Variable, um den Modus des Popups zu verfolgen
var popupMode = false;
