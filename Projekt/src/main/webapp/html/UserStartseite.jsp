<!-- Autor:  @Selim-->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="de_DE" />

<!DOCTYPE html>
<html lang="de">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
		<title>Startseite - Kapitalismus-Kasse</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/UserStartseite_Design.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
		<script src="${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
		<script src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
	 	<script src="${pageContext.request.contextPath}/JavaScript/navigation_intern.js"></script>
		
	
	</head>
	
<body>

	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="image">
					<div class="company-name">Kapitalismus<br> Kasse
					</div>
				</div>
			</li>
			<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" class="active" title="Sehen Sie sich Ihr Dashboard an!">Dashboard</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" title="Überweisen Sie bequem Ihr Geld!">Überweisung</a></li>
			<li><a href="${pageContext.request.contextPath}/VerlaufServlet" title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a></li>
			<li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp" title="Holen Sie sich Hilfe!">Hilfe</a></li>
			<li class="no-hover">
			<a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" title="Nutzerdaten verwalten"> 
				<img src="${pageContext.request.contextPath}/img/accountBild.jpg"	alt="Benutzerverwaltung" class="accountBild"></a>
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
	<br>

	<div class="grauBackground">
		<div class="profile-box">
			<div class="profilbild">
				<img src="${pageContext.request.contextPath}/DisplayImageServlet"
					alt="Profilbild" />
			</div>
			<div class="profile-text">
				<p id="greeting">
					Guten Tag, <span id="vorname">${sessionScope.vorname}</span>
					<span id="nachname">${sessionScope.nachname}</span></p>
			</div>
		</div>
		
		<div class="kontoinformationen">
			<p id="ubersicht">Übersicht:</p>
			<p id="kontostand">Saldo: <fmt:formatNumber value="${sessionScope.kontostand}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>€
			<p id="iban">IBAN: ${sessionScope.formattedIban}</p>
			<p id="disporahmen">Disporahmen: <fmt:formatNumber value="${sessionScope.dispo}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>€</p>
		</div>

	<div class="verlinkungen">
	 <div class="yellow-background">
		<div class="aktion">
				<p class="aktiontitel">Was möchten Sie machen?</p>
				</div>
				<div class="aktion">
					<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Ueberweisungen.jsp'">Geld überweisen</button>
				</div>
				<div class="aktion">
					<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/VerlaufServlet'">Buchungsverlauf ansehen</button>
				</div>
				<div class="aktion">
					<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Kontoauszuege.jsp'">Kontoauszüge ansehen</button>
				</div>
				<div class="aktion">
					<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/hilfeIntern.jsp#kontaktFeld'">Support kontaktieren</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="kredit-rechner">
    <h2>Kredit-Rechner</h2>
    <div class="input-container">
        <label for="kredithoehe">Kredithöhe (in Euro):</label>
        <input type="number" id="kredithoehe" min="1000" max="100000" step="1000" value="10000">
    </div>
    <div class="input-container">
        <label for="laufzeit">Laufzeit (in Monaten):</label>
        <input type="range" id="laufzeit" min="6" max="90" value="24">
        <output id="laufzeit-anzeige">12 Monate</output>
    </div>
    <div class="input-container">
        <label>Monatliche Rate (inkl. 21,5% Zins):</label>
        <output id="rate-anzeige">0,00€</output>
    </div>
</div>
<script  src="${pageContext.request.contextPath}/JavaScript/kredit.js"></script>
	
	<div class="sicherheitshinweise">
    <h2>Sicherheitshinweise</h2>
    <ul>
        <li>Halten Sie Ihre Zugangsdaten geheim und teilen Sie sie niemals mit anderen.</li>
        <li>Aktualisieren Sie regelmäßig Ihre Pin.</li>
        <li>Überprüfen Sie Ihre Kontobewegungen regelmäßig auf verdächtige Aktivitäten.</li>
    </ul>
</div>

	<!-- Footer -->
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>

</body>
</html>
