//Autor: @Selim, @Can

"use strict";


window.addEventListener("scroll", function() {
    var nav = document.querySelector("#navbar");
    var image = document.querySelector(".image");
    var timerContainer = document.querySelector(".timer-logout-container");
    var timer = document.querySelector("#timer");
    var logoutButton = document.querySelector(".logout-button");
    var accountImage = document.querySelector(".accountBild");

    var smallNavHeight = 42; // Höhe der verkleinerten Navigationsleiste
    var smallNavImageSize = 36; // Größe des verkleinerten Logos
    var imageTopOffset = 8; // Gewünschter vertikaler Versatz des Logos beim Scrollen
    
    var smallTimerFontSize = "8px"; // Verkleinerte Schriftgröße des Timers
    var smallButtonFontSize = "8px"; // Verkleinerte Schriftgröße des Logout-Buttons
    var smallContainerPadding = "0px"; // Verkleinerte Innenabstände des Containers

    if (window.scrollY > 0) {
        nav.classList.add("small");
        // Animation für die Verkleinerung der Navigationsleiste
        nav.style.transition = "height 0.2s ease-in-out";
        nav.style.height = smallNavHeight + "px";

        // Bild verkleinern und rechtsbündig positionieren
        image.style.width = smallNavImageSize + "px";
        image.style.height = smallNavImageSize + "px";
        image.style.left = "35px"; // Zurücksetzen der linken Position
        image.style.right = "12px"; // Positioniere rechts
        image.style.top = "-" + imageTopOffset + "px"; // Versatz nach oben hinzufügen

        // Timer und Logout-Container anpassen
        timerContainer.style.padding = smallContainerPadding;
        timer.style.fontSize = smallTimerFontSize;
        logoutButton.style.fontSize = smallButtonFontSize;

        // Konto-Bild verkleinern und rechtsbündig positionieren
        accountImage.classList.add("small-account-image");
    } else {
        nav.classList.remove("small");
        // Animation für die Vergrößerung der Navigationsleiste
        nav.style.transition = "height 0.2s ease-in-out";
        nav.style.height = ""; // Zurücksetzen auf die Standardhöhe
        
        // Bild zurücksetzen und linksbündig positionieren
        image.style.width = ""; // Zurücksetzen auf die Standardbreite
        image.style.height = ""; // Zurücksetzen auf die Standardhöhe
        image.style.right = ""; // Zurücksetzen auf die Standardposition
        image.style.left = "12px"; // Positioniere links
        image.style.top = ""; // Zurücksetzen des vertikalen Versatzes

        // Timer und Logout-Container zurücksetzen
        timerContainer.style.padding = ""; // Zurücksetzen auf die Standard-Padding
        timer.style.fontSize = ""; // Zurücksetzen auf die Standard-Schriftgröße
        logoutButton.style.fontSize = ""; // Zurücksetzen auf die Standard-Schriftgröße

        // Konto-Bild zurücksetzen
        accountImage.classList.remove("small-account-image");
    }
});
