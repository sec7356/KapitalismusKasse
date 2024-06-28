<!-- Autor: @Selim -->

<!-- KORREKTUR  NOTWENDIG-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Kontoauszüge - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
    <script  src= "${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
    <script  src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
</head>
<body>

<nav id="navbar">
	<ul>
		<li>
				<div class="container">
					<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
					title="Die Bank der Zukunft!">
					<img src="${pageContext.request.contextPath}/img/logo.jpg"
						alt="Logo" class="imageMitLink"></a>
					
					<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
					title="Die Bank der Zukunft!" class="companyNameLink">
						<span>Kapitalismus-</span>
						<span>Kasse</span></a>
					
				</div>
			</li>
		<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
		title="Sehen Sie sich Ihr Dashboard an!">Dashboard</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp"
		title="Überweisen Sie bequem Ihr Geld!">Überweisung</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/VerlaufServlet"
		title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp"
			title="Holen Sie sich Hilfe!">Hilfe</a>
			</li>
			<li>
		<li> <!-- Benutzer verwalten Icon -->
        	<a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" title="Nutzerdaten verwalten">
        	<img src="${pageContext.request.contextPath}/img/accountBild.jpg" alt="Benutzerverwaltung" class="accountBild">
        	</a>
        </li>
		<li>
			<div class="timer-logout-container">
                <div id="timer">05:00</div>
                <div class="divider"></div>
                <form method="post" action="${pageContext.request.contextPath}/LogoutServlet">
                    <button name="loeschen" type="submit" class="logout-button" title="Melden Sie sich sicher ab!">Logout</button>
                </form>
            </div>
		</li>
	</ul>
</nav>

<div class="grauBackground">
	<br><br><br><br>												<!-- falsch formatiert -->
	<p>Guten Tag, <%= session.getAttribute("vorname") %> <%= session.getAttribute("nachname") %>!</p>		
	<p>Hier können Sie Ihre Kontoauszüge sehen und herunterladen.</p>
</div> <br> <br>

<div class="internForm">
			<fieldset>
				<legend>Es tut uns Leid!</legend>
				
				<p>Wir als Kapitalismus-Kasse legen großen Wert auf Nachhaltigkeit und Effizienz. Durch den Verzicht auf 
				Kontoauszüge sparen wir wertvolle Ressourcen und reduzieren unseren ökologischen Fußabdruck. Zudem bieten unsere 
				digitalen Plattformen jederzeit einen sicheren und schnellen Zugriff auf Ihre Kontoinformationen, wodurch diese Dokumente 
				überflüssig werden.</p>
			</fieldset>

	</div>

		<!-- Entweder so lassen (nur als Aufruf von Startseite) oder komplett löschen -->


<footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>