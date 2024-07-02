<!-- Validiert am 28.06 @Can -->
<!-- Autor: @Can, @Selim -->
<!-- onclick für die Buttons noch drin -->

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
</head>
<body>

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
			<li><a href="${pageContext.request.contextPath}/index.jsp" class="active">Privatkunden</a></li>
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
				Deine Bank<br> Unser Geld!
			</div>
			<div class="text_info">
				Denn als Gemeinschaftsbank <br> gehören wir unseren
				Mitgliedern. <br>Bei uns könnt Ihr Geld gut aufbewahren.
			</div>
			<img src="${pageContext.request.contextPath}/img/Bild3.jpg" alt="Logo">
		</div>

		<div class="mySlides fade">
			<div class="text">
				Kleine Summen<br> Großer Effekt!
			</div>
			<div class="text_info">
				Ihre kleinen Summen bedeuten <br> für uns viel. Denn auch <br>diese gehören uns!
			</div>
			<img src="${pageContext.request.contextPath}/img/Bild2.jpeg" alt="Menschen voir Solarpanel">
		</div>

		<div class="mySlides fade">
			<div class="text">
				Ihr lacht?<br> Wir lachen mehr!
			</div>
			<div class="text_info">
				Ihr lacht, weil ihr die wahren <br> Absichten nicht kennt. Wir lachen, weil <br>wir die wahren Absichten kennen!
			</div>
			<img src="${pageContext.request.contextPath}/img/Bild1.jpeg" alt="Lachende Menschen auf Sofa">
		</div>

		<div class="dots">
			<span class="dot"></span> <span class="dot"></span> <span class="dot"></span>
		</div>

		<a class="prev" id="prevButton">&#10094;</a>
		<a class="next" id="nextButton">&#10095;</a>
	</div>

	
	<script src="${pageContext.request.contextPath}/JavaScript/slideshow.js"></script>

	<br>
	<br>
	<br>
	<p id="Banktext">Was Sie als Kunde wissen müssen</p>

	<div class="grid-container">
		<div class="grid-item">
			Bargeld wächst nun auf Bäumen!<br>
			<br>Neu! Forscher fanden eine spezielle Art von Pflanzen aus einer Nachbargalaxie, worauf Euro-Scheine wachsen.
			Desshalb jetzt 100€ Startguthaben bei der Registrierung als Neukunde!
			<br><br>
			<a href="${pageContext.request.contextPath}/html/kptNews.jsp">Mehr</a>
		</div>
		<div class="grid-item">
			Selbstständig werden?<br>
			<br>Wir unterstützen Sie auch bei dieser Herausforderung mit
			unseren attraktiven Angeboten. Sie werden jedoch trotzdem nicht erfolgreich!<br>
			<br><br>
			<a href="${pageContext.request.contextPath}/html/kptNews.jsp">Mehr</a>
		</div>
		<div class="grid-item">
			Sie haben Ihr Geld versoffen?<br>
			<br>Keine Sorge!<br>Mit unsereren attraktiven
			Kredit-Angeboten katapultieren wir Sie in die nächstgrößere
			Katastrophe!<br>
			<br>
			<a href="${pageContext.request.contextPath}/html/kptNews.jsp">Mehr</a>
		</div>
	</div>

	
	<article class="contentIndex">
        <h2>Darum Kapitalismus Kasse</h2>
        <div class="flexIndexContainer">
            <div class="content-item">
                <img src="${pageContext.request.contextPath}/img/beratung.png" alt="Persönliche Beratung und Unterstützung">
                <p>Persönliche Beratung und Unterstützung</p>
            </div>
            <div class="content-item">
                <img src="${pageContext.request.contextPath}/img/macht.png" alt="Globale politische Macht">
                <p>Globale politische Macht</p>
            </div>
            <div class="content-item">
                <img src="${pageContext.request.contextPath}/img/online.png" alt="Innovatives Online-Banking">
                <p>Innovatives Online-Banking</p>
            </div>
            <div class="content-item">
                <img src="${pageContext.request.contextPath}/img/professionell.png" alt="Professionelles Management-Team">
                <p>Professionelles Management-Team</p>
            </div>
        </div>
    </article>
    
    <aside class="faq-section">
    <h2>FAQ - Häufig gestellte Fragen</h2>
    
            <div class="faq-item">
                <h2 class="faq-question">• Wie funktioniert das Online-Banking bei euch?</h2>
                <p class="faq-answer">Unser Online-Banking ermöglicht es Ihnen, alle Ihre Bankgeschäfte bequem von zu Hause oder unterwegs 
                zu erledigen. Sie können Überweisungen tätigen, Ihren Kontostand überprüfen, Daueraufträge einrichten und vieles mehr.</p>
            </div>
            
            <div class="faq-item">
                <h2 class="faq-question">• Wie melde ich mich für das Online-Banking an?</h2>
                <p class="faq-answer">Um sich für das Online-Banking anzumelden, besuchen Sie unsere Webseite und klicken Sie auf den 
                "Login"-Button. Folgen Sie den Anweisungen zur Anmeldung und Verifizierung Ihrer Identität.</p>
            </div>
            
            <div class="faq-item">
                <h2 class="faq-question">• Welche Sicherheitsmaßnahmen gibt es beim Online-Banking?</h2>
                <p class="faq-answer">Wir verwenden die neuesten Sicherheitsprotokolle, einschließlich SSL-Verschlüsselung und 
                Google Recaptcha-Algorithmus, um Ihre Daten zu schützen und Ihre Transaktionen sicher zu machen.</p>
            </div>
            
            <div class="faq-item">
                <h2 class="faq-question">• Wie erreiche ich den Kundenservice?</h2>
                <p class="faq-answer">Unser Kundenservice ist per E-Mail erreichbar. Besuchen Sie unsere Kontaktseite für weitere Informationen.</p>
            </div>
            
            <div class="faq-item">
                <h2 class="faq-question">• Kann ich meine Kontoinformationen auch mobil abrufen?</h2>
                <p class="faq-answer">Ja, mit unserer mobilen App haben Sie jederzeit und überall Zugriff auf Ihre Kontoinformationen. Die App ist für iOS und Android verfügbar.</p>
            </div>
            
            <div class="faq-item">
		    <h2 class="faq-question">• Wie ändere ich mein Online-Banking Passwort?</h2>
		    <p class="faq-answer">Um Ihr Passwort für das Online-Banking zu ändern, loggen Sie sich ein und navigieren Sie zu den 
		    Kontoeinstellungen. Dies befindet sich auf der oberen rechten Seite des Bildschirms. Dort finden Sie die Option zur 
		    Passwortänderung.</p>
			</div>
		
			<div class="faq-item">
		    <h2 class="faq-question">• Gibt es eine Begrenzung für Überweisungen über das Online-Banking?</h2>
		    <p class="faq-answer">Ja, für Ihre Sicherheit gibt es tägliche und wöchentliche Limits für Überweisungen über das 
		    Online-Banking. Diese können Sie in den Einstellungen Ihres Kontos einsehen und verwalten.</p>
			</div>
        </aside>
    
    
    <article class="regBox">
	<br>
		<h2>Registrieren Sie sich jetzt als Firmenkunde!</h2>
		<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Registrierung.jsp'">Klicken zum Registrieren</button>
		<h3>Bereits registriert?</h3>
		<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Banking-Login.jsp'">Klicken zum Anmelden</button>
		<h3>Passwort vergessen?</h3>
		<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/hilfe.jsp'">Klicken für Hilfe</button>
	</article>

	<!-- Footer -->
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>

</body>
</html>
