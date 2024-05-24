// JavaScript, um die Breite des Unterstrichs dynamisch anzupassen
document.addEventListener("DOMContentLoaded", function() {
    // Wähle alle aktiven Links aus
    var activeLinks = document.querySelectorAll("nav a.active");

    // Iteriere über die aktiven Links
    activeLinks.forEach(function(link) {
        // Setze die Breite des Unterstrichs auf die Breite des Textinhalts
        var width = link.offsetWidth;
        link.style.setProperty("--underline-width", width + "px");
    });
});
