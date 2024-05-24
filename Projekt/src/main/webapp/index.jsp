<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page errorPage="fehlermeldungAllgemein.jsp"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="img/favicon.ico" />
<title>Kapitalismus Kasse - Deine Bank!</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<img src="img/logo.jpg" alt="Logo" class="image">
					<div class="company-name">
						Kapitalismus-<br> Kasse
					</div>
				</div>
			</li>
			<li><a href="html/Main.jsp" class="active">Privatkunden</a></li>
			<li><a href="html/Firmenkunden.jsp">Firmenkunden</a></li>
			<li><a href="html/Immobilien.jsp">Immobilien</a></li>
			<li><a href="html/Karriere.jsp">Karriere</a></li>
			<li><a href="html/Banking-Login.jsp">Banking-Login</a></li>
		</ul>
	</nav>

	<!-- Slide-Show-Inhalt -->

	<div class="slideshow-container">
		<div class="mySlides fade">
			<div class="text">
				Deine Bank<br> Unser Geld!
			</div>
			<div class="text_info">
				Denn als Gemeinschaftsbank <br> gehören wir unseren
				Mitgliedern. <br>Bei uns könnt Ihr Geld gut aufbewahren.
			</div>
			<img src="img/Bild3.jpg">
		</div>

		<div class="mySlides fade">
		<div class="text">
				Kleine Summen<br> Großer Effekt!
			</div>
			<div class="text_info">
				Ihre kleinen Summen bedeuten <br> für uns viel. Denn auch <br>diese gehören uns!
			</div>
			<img src="img/Bild2.jpeg">
		</div>

		<div class="mySlides fade">
		<div class="text">
				Ihr lacht?<br> Wir lachen mehr!
			</div>
			<div class="text_info">
				Ihr lacht, weil ihr die wahren <br> Absichten nicht kennt. Wir lachen, weil <br>wir die wahren Absichten kennen!
			</div>
			<img src="img/Bild1.jpeg">
		</div>


		<div class="dots">
			<span class="dot"></span> <span class="dot"></span> <span class="dot"></span>
		</div>

		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>

	</div>

	<script src="JavaScript/navigation_extended.js"></script>
	<script src="JavaScript/navigation.js"></script>
	<script src="JavaScript/slideshow.js"></script>

	<!--  Weiterer Inhalt unter der SlideShow -->

	<br>
	<br>
	<br>
	<p id="Banktext">Was Sie als Kunde wissen müssen</p>

	<div class="grid-container">
		<div class="grid-item">
			Bargeld wächst nun auf Bäumen!<br>
			<br>Neu! Forscher fanden eine spezielle Art von Pflanzen aus einer Nachbargalaxie, worauf Euro-Scheine wachsen.
			<br><br>
			<a href="#">Mehr</a>
		</div>
		<div class="grid-item">
			Selbstständig werden?<br>
			<br>Wir unterstützen Sie auch bei dieser Herausforderung mit
			unseren attraktiven Angeboten. Sie werden jedoch trotzdem nicht erfolgreich!<br>
			<br>
			<a href="#">Mehr</a>
		</div>
		<div class="grid-item">
			Sie haben Ihr Geld versoffen?<br>
			<br>Keine Sorge!<br>Mit unsereren attraktiven
			Kredit-Angeboten katapultieren wir Sie in die nächstgrößere
			Katastrophe!<br>
			<br>
			<a href="#">Mehr</a>
		</div>
	</div>


	<article>
	<br>
		<h2>Registrieren Sie sich jetzt als Firmenkunde!</h2>
		<a href="html/Registrierung.jsp" class="black-anchor">
			<button>Klicken zum Registrieren</button>
		</a>
		<h3>Bereits registriert?</h3>
		<p>
			Klicken sie zum Einloggen <a href="html/Banking-Login.jsp"
				class="black-anchor">hier</a>.
		</p>
		<h3>Passwort vergessen?</h3>
		<p>
			Hilfe finden Sie <a href="html/passwortReset.jsp" class="black-anchor">hier</a>.
		</p>
	</article>


	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>

</body>
</html>
