<!-- Autor: @Selim -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
<title>Kapitalismus Kasse - Deine Bank!</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleExtern.css">
<script src="${pageContext.request.contextPath}/JavaScript/navigation_extern.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/cookieCheck_extern.js"></script>
</head>
<body>
	<div id="cookieSuccess">✅ Cookie-Zugriff erfolgreich!</div>
	    <div id="cookieWarning">Bitte aktivieren Sie Ihre Cookies um fortzufahren!<br>
	        <button id="reloadButton">Neu laden</button>
   		</div>
   		
<noscript>
<div class="noscript-message-container">
            <div class="noscript-message">
                JavaScript ist deaktiviert. Bitte aktivieren Sie JavaScript, um diese Webseite vollständig nutzen zu können.
            </div>
        </div>
</noscript>

	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="image">
					<div class="company-name">Kapitalismus<br> Kasse
					</div>
				</div>
			</li>
			<li><a href="${pageContext.request.contextPath}/index.jsp">Privatkunden</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Firmenkunden.jsp">Firmenkunden</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp">Immobilien</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp">Karriere</a></li>
			<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Banking-Login</a></li>
		</ul>
	</nav>

	<!-- Slide-Show-Inhalt -->

	<div class="slideshow-container">
		<div class="mySlides fade">
			<div class="text">
				Kapitalismus<br> Nachrichten
			</div>
			<div class="text_info">
				Vertrauenswürdige Nachrichten -  <br> von vertrauenswürdigen Personen <br>zu vertrauenswürdigen Personen
			</div>
			<img src="${pageContext.request.contextPath}/img/kptNews.jpg" alt="Logo">
		</div>


		<div class="mySlides fade">
			<div class="text">
				Ihr lacht?<br> Wir lachen mehr!
			</div>
			<div class="text_info">
				Ihr lacht, weil ihr die wahren <br> Absichten nicht kennt. Wir lachen, weil <br>wir die wahren Absichten kennen!
			</div>
			<img src="${pageContext.request.contextPath}/img/kptZeitung.jpg" alt="Lachende Menschen auf Sofa">
		</div>

		<div class="dots">
			<span class="dot"></span> <span class="dot"></span> <span class="dot"></span>
		</div>

		<a class="prev" id="prevButton">&#10094;</a>
 		<a class="next" id="nextButton">&#10095;</a>

	</div>

	
	<script src="${pageContext.request.contextPath}/JavaScript/slideshow.js"></script>

	<!-- Weiterer Inhalt unter der SlideShow -->

	<br>
	<br>
	<br>
	<p id="Banktext">Aktuelles für Sie</p>

	<div class="grid-container">
		<div class="grid-item">
			<p class="bold">Bargeld wächst nun auf Bäumen!</p><br>
			<br>Neu! Forscher fanden eine spezielle Art von Pflanzen aus einer Nachbargalaxie, worauf Euro-Scheine wachsen.
			Desshalb jetzt 100€ Startguthaben bei der Registrierung als Neukunde!
			<br><br>
			Diese sensationelle Entdeckung hat nicht nur die wissenschaftliche Gemeinschaft in Aufruhr versetzt, sondern 
			bietet auch unglaubliche wirtschaftliche Möglichkeiten. <br><br>Die Pflanzen, die in einer bislang unbekannten Galaxie entdeckt wurden, 
			gedeihen unter speziellen Bedingungen und produzieren tatsächlich Euro-Scheine als Blätter. Durch diese revolutionäre Entdeckung 
			könnte sich die gesamte Finanzwelt verändern, da Geld nun buchstäblich auf Bäumen wächst.<br><br> Um von dieser einmaligen Gelegenheit zu 
			profitieren, bieten wir dir jetzt 100€ Startguthaben bei der Registrierung als Neukunde an. Nutze diese Chance und sei Teil einer 
			neuen Ära des Wohlstands! Registriere dich noch heute und erlebe die Zukunft des Geldes hautnah.
		
		</div>
		<div class="grid-item">
			<p class="bold">Selbstständig werden?</p><br>
			<br>Wir unterstützen Sie auch bei dieser Herausforderung mit
			unseren attraktiven Angeboten. Sie werden jedoch trotzdem nicht erfolgreich!<br><br>
			Dies mag zunächst entmutigend klingen, doch es gibt gute Nachrichten: Mit der richtigen Anleitung und den passenden Ressourcen kann 
			jeder die Kunst des Unternehmertums meistern. <br><br>Unser Expertenteam steht Ihnen zur Seite, um Sie auf jedem Schritt Ihres Weges zu 
			begleiten. Von der Geschäftsplanung bis hin zur Marketingstrategie bieten wir umfassende Unterstützung. <br>Lassen Sie uns gemeinsam 
			Ihre Vision verwirklichen und den Weg zum Erfolg ebnen.
		</div>
		<div class="grid-item">
			<p class="bold">Sie haben Ihr Geld versoffen?</p><br>
			<br>Keine Sorge!<br>Mit unsereren attraktiven
			Kredit-Angeboten katapultieren wir Sie in die nächstgrößere
			Katastrophe!<br><br>
			Doch verzweifeln Sie nicht, denn es gibt immer einen Weg zurück zur finanziellen Stabilität. Unsere erfahrenen Berater helfen Ihnen,
			 einen soliden Rückzahlungsplan zu erstellen, der zu Ihrer Situation passt.<br><br> Nutzen Sie unsere speziellen Programme zur 
			 Schuldenregulierung und lassen Sie sich von uns auf dem Weg aus der finanziellen Misere unterstützen. <br>Gemeinsam finden wir eine 
			 Lösung, die Ihnen langfristig wieder auf die Beine hilft.
		</div>
	</div>

	<p id="weiteres">-Wir haben bald weitere Artikel für sie. Werden Sie unser Kunde und bleiben Sie auf dem aktuellsten Stand!-</p>
    
   <article class="regBox">
		<h3>Registrieren Sie sich jetzt!</h3>
		<a href="${pageContext.request.contextPath}/html/Registrierung.jsp" class="FakeButtonStyle">Klicken zum Registrieren</a>
		<h3>Bereits registriert?</h3>
		<a href="${pageContext.request.contextPath}/html/Banking-Login.jsp" class="FakeButtonStyle">Klicken zum Anmelden</a>
		<h3>Benötigen Sie Hilfe?</h3>
		<a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="FakeButtonStyle">Klicken für Hilfe</a>
	</article>

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>

</body>
</html>
