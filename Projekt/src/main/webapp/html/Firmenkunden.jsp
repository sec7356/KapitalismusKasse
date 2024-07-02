<!-- Autor: @Can, @Selim -->
<!-- validiert -->
<!-- in Zeile 58, 59, 125, 127, 129 wird onclick verwendet, das muss noch geändert werden -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <title>Firmenkunden - Kapitalismuss-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleExtern.css">
    <script src="${pageContext.request.contextPath}/JavaScript/navigation_extern.js"></script>
    <script src="${pageContext.request.contextPath}/JavaScript/cookieCheck.js"></script>
</head>
<body>

<div id="cookieSuccess">✅ Cookie-Zugriff erfolgreich!</div>
    <div id="cookieWarning">Bitte aktivieren Sie Ihre Cookies um fortzufahren!<br>
        <button id="reloadButton">Neu laden</button>
    </div>

<nav id="navbar">
	<ul>
		<li>
			<div class="container">
					<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="image">
					<div class="company-name">Kapitalismus<br> Kasse</div>
			</div>
		</li>
		<li><a href="${pageContext.request.contextPath}/index.jsp">Privatkunden</a></li>
		<li><a href="${pageContext.request.contextPath}/html/Firmenkunden.jsp" class="active">Firmenkunden</a></li>
		<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp">Immobilien</a></li>
		<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp">Karriere</a></li>
		<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Banking-Login</a></li>
	</ul>
</nav>

<!-- Slide-Show-Inhalt -->

<div class="slideshow-container">
  <div class="mySlides fade">
  	<div class="text">Deine Firma<br> Unsere Firma!</div>
  	<div class="text_info">Denn als Gemeinschaftsbank <br> teilen wir alles mit unseren Mitgliedern. <br>Bei uns ist Ihre Firma sicher!</div>
    <img src="${pageContext.request.contextPath}/img/Bild4.jpg" alt="Werbung">
  </div>
  <div class="mySlides fade">
  <div class="text">Kapitalismus für<br> alle Firmen!</div>
  	<div class="text_info">Wir als Kapitalismus Kasse setzen <br> Wert auf das Kapitalismus. Und so <br>machen es auch unsere Firmenkunden!</div>
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

    <aside class="vorteile">
        <h2>Ihre Vorteile bei uns als Firmenkunde:</h2>
        <ul>
        <li>Kostenlose Internationale Überweisungen jeglicher Art</li>
        <li>Rund um die Uhr Support-Möglichkeiten mit unseren Betreuern</li>
        <li>Überweisungen ohne die Überwachung Ihrer Firma</li>
        <li>High-Level Support für Ihre Geldwäsche</li>
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
        <h3>Registrieren Sie sich jetzt!</h3>
    	<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Registrierung.jsp'">Klicken zum Registrieren</button>        
       <h3>Bereits registriert?</h3>
		<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Banking-Login.jsp'">Klicken zum Anmelden</button>
        <h3>Benötigen Sie Hilfe?</h3>
        <button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/kontakt.jsp'">Klicken für Hilfe</button>
    </article>  

    <!-- Footer -->
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>
</body>
</html>
