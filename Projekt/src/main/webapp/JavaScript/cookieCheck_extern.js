//Autor: @Selim

"use strict";

document.addEventListener("DOMContentLoaded", function() {
    checkCookiesEnabled();

    var reloadButton = document.getElementById("reloadButton");
    if (reloadButton) {
        reloadButton.addEventListener("click", function() {
            location.reload();
        });
    }
});

function checkCookiesEnabled() {
    try {
        // Versuch einen Test-Cookie zu setzen
        document.cookie = "testcookie=1; path=/";
        var cookiesEnabled = document.cookie.indexOf("testcookie") !== -1;

        if (cookiesEnabled) {
            // Cookie löschen
            document.cookie = "testcookie=1; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            if (!getCookie('successShown')) {
                showSuccessPopup();
                setCookie('successShown', '1', 1); // Cookie setzen für einen Tag
            }
        } else {
            showAlert();
        }
    } catch (error) {
        console.error("Fehler beim Überprüfen der Cookies:", error);
        showAlert();
    }
}


function showSuccessPopup() {
    var successPopup = document.getElementById("cookieSuccess");
    if (successPopup) {
        successPopup.style.display = "block";
        setTimeout(() => {
            successPopup.style.display = "none";
            // Leitet den Benutzer nach einer kurzen Verzögerung weiter
        }, 0);
    }
}

function showAlert() {
    alert("Bitte aktivieren Sie Ihre Cookies um fortzufahren");
    // Seite neu laden nach dem Schließen des Alerts
    location.reload();
}

function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + (value || "") + expires + "; path=/";
}

function getCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}
