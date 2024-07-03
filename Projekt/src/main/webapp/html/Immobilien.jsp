<!-- Autor: @Selim, @Can -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <title>Immobilien - Kapitalismuss-Kasse</title>
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
		<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp" class="active">Immobilien</a></li>
		<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp">Karriere</a></li>
		<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Banking-Login</a></li>
	</ul>
</nav>


<!-- Slide-Show-Inhalt -->

<div class="slideshow-container">
  <div class="mySlides fade">
  	<div class="text">Geld ist Immobilien<br> und Immobilien ist Geld</div>
  	<div class="text_info">Sichern Sie sich jetzt die  <br>attraktivsten Angebote zu Finanzierungen <br>und Krediten!</div>
    <img src="${pageContext.request.contextPath}/img/immo.jpg" alt="Werbung">
  </div>

  <div class="mySlides fade">
  <div class="text">Sie haben<br>ein Plan?</div>
  	<div class="text_info">Wir setzen ihn um! <br>Sie bringen die Ideen, wir das Geld - <br>denn davon haben wir viel!</div>
    <img src="${pageContext.request.contextPath}/img/Bild2.jpeg" alt="Werbung">
  </div>
  

  <div class="dots">
  		<span class="dot"></span> 
  		<span class="dot"></span> 
 </div>

  <a class="prev" id="prevButton">&#10094;</a>
  <a class="next" id="nextButton">&#10095;</a>

</div>

	<script src="${pageContext.request.contextPath}/JavaScript/slideshow.js"></script>

<br><br><br><br>

<!-- Vorteile oder Informationen als Liste -->

    <aside class="vorteile">
        <h2>Ihre Vorteile bei uns für Ihre Immobilien:</h2>
        <ul>
        <li>schnelle und einfache Finanzierungen</li>
        <li>personalisierte Kapitalismus-Beratung</li>
        <li>rein digitale Dienste zu jeder Uhrzeit verfügbar</li>
        <li>transparente Gebührenstruktur</li>
        </ul>
    </aside>
    
    
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
        <h3>Registrieren Sie sich jetzt um Ihre Immobilien zu verwalten!</h3>
    	<a href="${pageContext.request.contextPath}/html/Registrierung.jsp" class="FakeButtonStyle">Klicken zum Registrieren</a>        
       
        <h3>Benötigen Sie Hilfe?</h3>
        <a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="FakeButtonStyle">Klicken für Hilfe</a>
    </article>

    <!-- Footer -->
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>
</body>
</html>
