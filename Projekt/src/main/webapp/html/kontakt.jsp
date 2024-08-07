<!-- Autoren: Diane, Selim -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <title>Kontakt - Kapitalismus-Kasse</title>
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
			<li><a href="${pageContext.request.contextPath}/html/hilfe.jsp">Hilfe</a></li>
			<li><a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="active">Kontakt</a></li>
			<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Zurück zum Login</a></li>
		</ul>
	</nav>
	
	<header class="titelHeader">
        Hier finden Sie Kontaktdaten zu Kapitalismus-Experten!
    </header>
    
    <aside class="helpBox">
        <h2>Ansprechpartner</h2>
        <ul class="abstandli">
            <li>Salih Can Pepeoglu: <a href="mailto:sap7224@thi.de">sap7224@thi.de</a></li>
            <li>Selim Cingitas: <a href="mailto:sec7356@thi.de">sec7356@thi.de</a></li>
            <li>Diane Stegmüller: <a href="mailto:dis8584@thi.de">dis8584@thi.de</a></li>
        </ul>
    </aside>
    
    <aside class="helpBox">
        <h2>Kapitalismus-Kasse Postfach:</h2>
        <ul class="abstandli">
            <li><a href="mailto:kpt-kasse@navalcadets.com">kpt-kasse@navalcadets.com</a></li>
        </ul>
    </aside>
    
    <article class="helpBox">
        <h2>Ein wenig Geduld bitte.</h2>
        <p>Vielen Dank für Ihr Interesse an unserer Website! Wir freuen uns über Ihr Feedback, 
        Ihre Fragen und Anregungen. Bitte haben Sie Verständnis dafür, dass wir aufgrund eines 
        hohen Aufkommens an Anfragen bis zu 4 Werktage benötigen, um Ihnen zu antworten. 
        Wir setzen alles daran, Ihnen schnellstmöglich weiterzuhelfen. 
        Vielen Dank für Ihre Geduld und Ihr Vertrauen.</p>
    </article><br>
    
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>
</body>
</html>