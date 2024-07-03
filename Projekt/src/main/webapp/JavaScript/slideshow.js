//Autor: Can - w3schools als Vorlage
//Quelle: https://www.w3schools.com/howto/howto_js_slideshow.asp

"use strict";

// Initialisierung des slideIndex
let slideIndex = 1;
showSlides(slideIndex);

// Funktion zur Anzeige der Slides basierend auf slideIndex
function showSlides(n) {
    let slides = document.getElementsByClassName("mySlides");
    let dots = document.getElementsByClassName("dot");

    // Überprüfen, ob n außerhalb des gültigen Bereichs liegt
    if (n > slides.length) {
        slideIndex = 1;
    }
    if (n < 1) {
        slideIndex = slides.length;
    }

    // Alle Slides ausblenden und aktive Klasse bei den Dots entfernen
    for (let i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (let i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }

    // Den gewünschten Slide anzeigen und den Dot aktivieren
    slides[slideIndex - 1].style.display = "block";
    dots[slideIndex - 1].className += " active";
}

// Funktion zum Inkrementieren bzw. Dekrementieren des slideIndex und Anzeigen der Slides
function plusSlides(n) {
    showSlides(slideIndex += n);
}

// Event-Handler für den "Vorheriger Slide" Button
document.getElementById("prevButton").addEventListener("click", function() {
    plusSlides(-1);
});

// Event-Handler für den "Nächster Slide" Button
document.getElementById("nextButton").addEventListener("click", function() {
    plusSlides(1);
});

// Automatisches Wechseln alle 10 Sekunden
setInterval(function() {
    plusSlides(1);
}, 10000);
