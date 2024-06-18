<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	
<fmt:setLocale value="de_DE" />
<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/img/favicon.ico" />
<title>Überweisung - Kapitalismus-Kasse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/Ueberweisungen_Design.css">
<script src="${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
</head>
<body>

	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<a
						href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
						title="Die Bank der Zukunft!"> <img
						src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo"
						class="imageMitLink"></a> <a
						href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
						title="Die Bank der Zukunft!" class="companyNameLink"> <span>Kapitalismus-</span><span>Kasse</span></a>
				</div>
			</li>
			<li><a
				href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
				title="Sehen Sie sich Ihr Dashboard an!">Dashboard</a></li>
			<li><a
				href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp"
				class="active" title="Überweisen Sie bequem Ihr Geld!">Überweisung</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/VerlaufServlet"
				title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a></li>
			<li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp"
			title="Holen Sie sich Hilfe!">Hilfe</a>
			</li>

			<li>
				<!-- Benutzer verwalten Icon --> <a
				href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp"
				title="Nutzerdaten verwalten"> <img
					src="${pageContext.request.contextPath}/img/accountBild.jpg"
					alt="Benutzerverwaltung" class="accountBild">
			</a>
			</li>
			<li>
				<div class="timer-logout-container">
					<div id="timer">05:00</div>
					<div class="divider"></div>
					<form method="post"
						action="${pageContext.request.contextPath}/LogoutServlet">
						<button name="loeschen" type="submit" class="logout-button"
							title="Melden Sie sich sicher ab!">Logout</button>
					</form>
				</div>
			</li>
		</ul>
	</nav>
	
	<main>
		<form method="post" action="${pageContext.request.contextPath}/UeberweisenServlet" accept-charset="UTF-8">
			<section>
				<fieldset class="account-info-container">
					<legend>Ihr Konto</legend>
					<div class="account-info">
						<div class="iban-info">
							<label for="von">IBAN:</label>  
                        <span>${sessionScope.formattedIban}</span>
						</div>
						<div class="saldo-info">
							<label for="konto-saldo">Aktueller Kontosaldo:</label> <span><fmt:formatNumber
									value="${sessionScope.kontostand}" type="number"
									groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" />
								€</span>
						</div>
					</div>
				</fieldset>

				<div class="new-transfer-header-container">
					<h2 class="new-transfer-header">Überblick</h2>
					<div class="progress-container">
						<div class="step second-step">1</div>
						<div class="step-description-2">Erfassung</div>
					</div>
					<div class="progress-container">
						<div class="step">2</div>
						<div class="step-description">Prüfen & Bestätigen</div>
					</div>
					<div class="progress-container">
						<div class="step second-step">3</div>
						<div class="step-description-2">Abschluss</div>
					</div>
				</div>
				<fieldset>
					<legend>Empfängerdaten</legend>
					<div class="form-group">
						<label for="nach">IBAN*</label><span>${requestScope.nach}</span>
					</div>
					<div class="form-group">
						<label for="nach">Vorname</label><span>${requestScope.nachVorname}</span>
					</div>
					<div class="form-group">
						<label for="nach">Nachname</label><span>${requestScope.nachNachname}</span>
					</div>
				</fieldset>
				<fieldset>
					<legend>Zahlungsdaten</legend>
					<div class="form-group">
						<label for="summe">Betrag* EUR</label> <span><fmt:formatNumber value="${requestScope.summe}" 
						type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</span>
					</div>
					<div class="form-group">
						<label for="betrag"></label>
						<p class="hint-text">
							Bitte beachten Sie eventuell die Meldepflicht ab 12.500 Euro <br>gemäß
							<a href="https://www.bundesbank.de/de/service/meldewesen/aussenwirtschaft" target="blank">Außenwirtschaftsverordnung<img src="${pageContext.request.contextPath}/img/Link.png" alt="Logo" style="vertical-align: middle; width: 30px; height: 30px; margin-left: -7px;"></a>
						</p>
					</div>

					<div class="form-group">
						<label for="verwendungszweck">Verwendungszweck</label> 
						<span>
							<!-- Verwendungszweck aus der Anfrage abrufen und anzeigen -->
							<c:choose>
    							<c:when test="${empty requestScope.verwendungszweck}">
        							<p> - keine Angaben - </p>
    							</c:when>
   								<c:otherwise>
       	 							<span>${requestScope.verwendungszweck}</span>
   		 						</c:otherwise>
							</c:choose>
						</span>
					</div>
					<div class="form-group">
						<label for="betrag"></label>
					</div>
					<div class="form-group">
						<label for="betrag">Hinweis</label>
						<p class="hint-text">
							Wir möchten Sie darauf hinweisen, dass Überweisungen
							ausschließlich an Empfänger durchgeführt werden können, die
							ebenfalls Kunden der Kapitalismus-Kasse sind.<br>
							<br> Dies gewährleistet die Sicherheit und Effizienz unserer
							Transaktionen innerhalb unseres Instituts.
						</p>
					</div>
					<br>
				</fieldset>

				<div class="button-container">
					<button type="button" class="korrigieren-button" onclick="history.back()">Korrigieren</button>
					<button name="submit" type="submit">Überweisen</button>

				</div>
			</section>
			<!-- 		Parameter werden an UeberweisenServlet weitergegeben, keine bessere Lösung gefunden!? @Can-->
			<input type="hidden" name="von" value="<%=session.getAttribute("IBAN")%>"> 
			<input type="hidden" name="nach" value="<%=request.getAttribute("nach")%>">
			<input type="hidden" name="summe" value="<%=request.getAttribute("summe")%>">
			<input type="hidden" name="verwendungszweck" value="<%=request.getAttribute("verwendungszweck")%>">
			
			
		</form>
	</main>

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>

