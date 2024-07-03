<!-- Autoren: Selim, Diane-->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <title>Hilfe - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hilfeKntStyle.css">
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
			<li><a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="active">Hilfe</a></li>
			<li><a href="${pageContext.request.contextPath}/html/kontakt.jsp">Kontakt</a></li>
			<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Zurück zum Login</a></li>
		</ul>
	</nav>
	
	<header class="titelHeader">
        Sie benötigen Hilfe? Wir helfen Ihnen!
    </header>
        
    <article class="helpBox">
        <h2>Einfache Fehlerbehandlung</h2>
        <p>Manchmal können bei der Benutzung unserer Anwendung Fehler auftreten. Hier sind einige Beispiele und Tipps, wie Sie mit ihnen umgehen können:</p>
        <ul>
            <li>Achten Sie auf Groß- und Kleinschreibung bei der Eingabe von Benutzernamen und Passwörtern.</li>
            <li>Überprüfen Sie Ihre Internetverbindung, wenn Sie Probleme beim Laden der Seite haben.</li>
            <li>Stellen Sie sicher, dass alle benötigten Felder korrekt ausgefüllt sind, bevor Sie Formulare absenden.</li>
            <li>Vergewissern Sie sich, dass Sie die neueste Version Ihres Browsers verwenden, um beste Leistung und Sicherheit zu gewährleisten.</li>
        </ul>
        </article>

		<article class="helpBox">
        <h2>Wie kontaktiere ich den Support?</h2>
        <p>Falls Sie Unterstützung benötigen, können Sie gerne unser Support kontaktieren:</p>
        <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="FakeButtonStyle">Klicken zum Kontaktieren</a>
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
        
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>
</body>
</html>
