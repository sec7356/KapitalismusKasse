<!-- Autor: Selim -->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
<title>Hilfe - Kapitalismus-Kasse</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/hilfeIntern.css">
<script  src= "${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
<script  src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
<script  src="${pageContext.request.contextPath}/JavaScript/navigation_intern.js"></script>
	
<script src="${pageContext.request.contextPath}/JavaScript/cookieCheck.js"></script>
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
			<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" title="Sehen Sie sich Ihr Dashboard an!">Dashboard</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" title="Überweisen Sie bequem Ihr Geld!">Überweisung</a></li>
			<li><a href="${pageContext.request.contextPath}/VerlaufServlet" title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a></li>
			<li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp"  class="active" title="Holen Sie sich Hilfe!">Hilfe</a></li>
			<li class="no-hover">
			<a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" title="Nutzerdaten verwalten"> 
				<img src="${pageContext.request.contextPath}/img/accountBild.jpg"	alt="Benutzerverwaltung" class="accountBild"></a>
			</li>
			<li><div class="timer-logout-container"><div id="timer">05:00</div><div class="divider"></div>
					<form method="post" action="${pageContext.request.contextPath}/LogoutServlet">
						<button name="loeschen" type="submit" class="logout-button" title="Melden Sie sich sicher ab!">Logout</button>
					</form>
				</div>
			</li>
		</ul>
	</nav>
	<br>

<div class="grauBackground">
    <br><br><br><br>                        
    <div class="profile-text">
        <p id="greeting">
            Guten Tag, <span id="vorname">${sessionScope.vorname}</span>
            <span id="nachname">${sessionScope.nachname}</span>
        </p>
    </div>
    <p>Sie suchen nach Hilfe? Dann sind Sie hier genau richtig!</p>
</div>
<br>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/hilfeMail.js"></script>

<div class="internForm">
    <form id="problemForm" method="post" action="mailto:kpt-kasse@navalcadets.com" enctype="multipart/form-data">
        <fieldset><legend>Formular zum Problem</legend>
        <div class="hilfeFormular">
        <div class="betreff">
            <label for="betreff">Betreff:</label><br>
            <input type="text" id="betreff" name="betreff" maxlength="30" placeholder="Titel oder Art des Problems..." required><br>
        </div>
        
            <label for="beschreibung">Beschreibung:</label><br>
            <textarea id="beschreibung" name="beschreibung" rows="10" cols="75" maxlength="500" 
            placeholder="Beschreiben Sie ausführlich Ihr Problem..." required></textarea><br>
        </div>
        <br>
        <div>
            <button name="submit" type="submit">Hilfe anfordern</button>
            <button name="reset" type="reset">Zurücksetzen</button>
        </div>
        </fieldset>
   </form>
</div>

    
	<br> <div class="teilOder">oder</div><br>

	<div class="internForm" id="kontaktFeld">
	            <fieldset><legend>Nehmen Sie direkten Kontakt auf!</legend>
	            
	            
	           <p>Zögern Sie nicht und kontaktieren Sie jederzeit unsere Kapitalismus-Experten!</p>
	           <p>Ansprechpartner:</p><ul class="reset-ul">
	           <li class="partner">Salih Can Pepeoglu: <a href="mailto:sap7224@thi.de">sap7224@thi.de</a></li>
	           <li class="partner">Selim Cingitas: <a href="mailto:sec7356@thi.de">sec7356@thi.de</a></li>
	           <li class="partner">Diane Stegmüller: <a href="mailto:dis8584@thi.de">dis8584@thi.de</a></li>
	            </ul><br>
		           </fieldset>
	    </div>


	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
