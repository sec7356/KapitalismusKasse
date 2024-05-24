window.addEventListener("scroll", function() {
	var nav = document.querySelector("#navbar");
	var image = document.querySelector(".image");
	var smallNavHeight = 42; // Höhe der verkleinerten Navigationsleiste
	var smallNavImageSize = 36; // Größe des verkleinerten Logos
	var imageTopOffset = 6; // Gewünschter vertikaler Versatz des Logos beim Scrollen


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
		image.style.top = ""; // Zurücksetzen auf die Standardposition

	}
});
