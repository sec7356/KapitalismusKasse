<!-- Autoren: Selim, Can-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <title>Karriere - Kapitalismuss-Kasse</title>
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
		<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp" class="active">Karriere</a></li>
		<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Banking-Login</a></li>
	</ul>
</nav>

<!-- Slide-Show-Inhalt -->

<div class="slideshow-container">
  <div class="mySlides fade">
  	<div class="text">Auf der Suche<br> nach Reichtum?</div>
  	<div class="text_info">Denn von jedem neuen Kunden  <br> profitieren unseren Mitglieder - <br>und auch wir!</div>
    <img src="${pageContext.request.contextPath}/img/Bild5.jpg" alt="Werbung">
  </div>

  <div class="mySlides fade">
  <div class="text">Wir sind<br> eine Familie!</div>
  	<div class="text_info">Denn jeder Mitarbeiter - und auch jeder <br>Kunde - hat für uns einen speziellen Wert. <br>Unzwar Geld!</div>
    <img src="${pageContext.request.contextPath}/img/Bild1.jpeg" alt="Werbung">
  </div>
  

  <div class="dots">
  		<span class="dot"></span> 
  		<span class="dot"></span> 
 </div>

 	<a class="prev" id="prevButton">&#10094;</a>
 	<a class="next" id="nextButton">&#10095;</a>

</div>


	<script src="${pageContext.request.contextPath}/JavaScript/slideshow.js"></script>

<br><br><br>

    <article class="karriereBox">
        <h2>Ihre Vorteile bei einer Karriere bei uns:</h2>
        <ul>
        <li>Einblicke auf alle Kontostände</li>
        <li>Anpassung des eigenen Kontostands</li>
        <li>Kostenlose Arbeitsbekleidung mit Kapitalismus-Kasse-Emblem</li>
        <li>Lebenslange Arbeitsgarantie</li>
        </ul>
         </article>
        
        <article class="karriereBox">
        <h2>Was wir von Ihnen erwarten:</h2>
        <ul>
        <li>Lebenslange Arbeitspflicht</li>
        <li>Keine Kentnisse oder Arbeitserfahrung notwendig</li>
        <li>Gefühlslosigkeit</li>
        <li>Fähigkeit realitätsnahe Lügen zu erfinden</li>
        </ul>
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
        <h3>Registrieren Sie sich jetzt um Ihre Karriere starten zu können!</h3>
    	<a href="${pageContext.request.contextPath}/html/Registrierung.jsp" class="FakeButtonStyle">Klicken zum Registrieren</a>
       
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
