<!-- Autor: Can -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="de_DE" />
<!DOCTYPE html>
<html lang="de">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
	<title>Überweisung - Kapitalismus-Kasse</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Ueberweisungen_Design.css">
	<script src="${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
	<script src="${pageContext.request.contextPath}/JavaScript/navigation_intern.js"></script>
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
			<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" class="active" title="Überweisen Sie bequem Ihr Geld!">Überweisung</a></li>
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

	<main>
	<form method="post" action="${pageContext.request.contextPath}/UeberweisungUeberpruefenServlet">
		<section>
			<fieldset class="account-info-container">
				<legend>Ihr Konto</legend>
				<div class="account-info">
					<div class="iban-info">
						<label>IBAN:</label> 
						<%
                            String iban = (String) session.getAttribute("IBAN");
                            String formattedIban = iban.replaceAll("(.{4})(?!$)", "$1 ");
                        %>
                        <span><%=formattedIban%></span>
					</div>
					<div class="saldo-info">
						<label>Neuer Kontosaldo:</label> <span><fmt:formatNumber value="${sessionScope.kontostand}" 
						type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/> €</span>
					</div>
				</div>
			</fieldset>

			<div class="new-transfer-header-container">
				<h2 class="new-transfer-header">Abschluss</h2>
				<div class="progress-container">
					<div class="step second-step">1</div>
					<div class="step-description-2">Erfassung</div>
				</div>
				<div class="progress-container">
					<div class="step second-step">2</div>
					<div class="step-description-2">Prüfen &amp; Bestätigen</div>
				</div>
				<div class="progress-container">
					<div class="step">3</div>
					<div class="step-description">Abschluss</div>
				</div>
			</div>
				<div class="img-container">
    				<img src="${pageContext.request.contextPath}/img/UeberweisungDone.jpg" alt="Logo">
				</div>
				<label id="done">Ihre Überweisung wurde erfolgreich durchgeführt!<br><br>
				Kapitalismus-Kasse: Geld fliegt schneller als Gedankenblitze.<br>Ihr Geld ist weg, bevor Sie es merken.<br><br>Treu unserem Motto: Ihr Geld gehört uns sowieso.<br></label><br>
				
			<div class="button-container">
			   	<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" class="buttonStyle">Zur Startseite</a>
			   	<a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" class="buttonStyle">Neue Überweisung</a>
			</div>
				
		</section>
		</form>
	</main>
	
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>

