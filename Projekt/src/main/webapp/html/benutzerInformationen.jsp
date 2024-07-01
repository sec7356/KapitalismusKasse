<!-- Autor: @Can-->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<fmt:setLocale value="de_DE" />

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
<title>Alle Buchungen - Kapitalismus-Kasse</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
<script src="${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/greetingAdmin.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/Zwischenablage.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/AccountLoeschen.js"></script>
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
			<li><h1 id="adminKonsoleTitel">**Admin-Konsole**</h1></li>
			
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
<br>
<div class="grauBackground">
		<br><br><br>							
		<div class="profile-text">
				<p id="greeting">
					Guten Tag, <span id="vorname">Admin</span>
				</p>
		</div>
		<p>Hier sehen Sie auf einen Blick alle relevanten Daten des Kunden und können Änderungen vornehmen!</p>
	</div>
	<br>
<div class="grauBackground">    
    <a href="${pageContext.request.contextPath}/AdminBenutzerListeServlet">Zurück zur Benutzersuche</a>
</div>

<div class="transaktionen">
    <div class="header-container">
        <h2>Benutzer-Informationen</h2>
        <div class="button-wrapper">
            <c:forEach var="benutzer" items="${benutzerinformationen}">
                <div class="button-container">
                    <form id="deleteForm" action="${pageContext.request.contextPath}/DeleteBenutzerServlet?b_id=${benutzer.b_id}" method="POST">
    					<button name="loeschen" type="button" class="delete-button" onclick="confirmDelete()" 
        				${sessionScope.b_id == benutzer.b_id ? 'disabled' : ''}>
        				${sessionScope.b_id == benutzer.b_id ? 'Account nicht löschbar' : 'Account löschen'}
    					</button>
					</form>
                    <a href="${pageContext.request.contextPath}/EditBenutzerServlet?b_id=${benutzer.b_id}" class="custom-button">Bearbeiten</a>
                </div>
            </c:forEach>
        </div>
    </div>
    <table class="transaktionen-table">
        <thead>
            <tr>
                <th>Vorname</th>
                <th>Nachname</th>
                <th>Email</th>
                <th>PIN</th>
                <th>Admin</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="benutzer" items="${benutzerinformationen}">
                <tr>
                    <td>${benutzer.vorname}</td>
                    <td>${benutzer.nachname}</td>
                    <td>${benutzer.email}</td>
                    <td>${benutzer.pin}</td>
                    <td>
                        <c:choose>
                            <c:when test="${benutzer.admin}"> Ja </c:when>
                            <c:otherwise>Nein</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <c:if test="${empty benutzerinformationen}">
        <p>Keine Benutzerinformationen gefunden.</p>
    </c:if>
</div>


    
<div class="transaktionen">
    <div class="header-container">
        <h2>Konto-Informationen</h2>
            <c:forEach var="benutzer" items="${benutzerinformationen}">
           	<div class="button-container"> <a href="${pageContext.request.contextPath}/EditKontoServlet?b_id=${benutzer.b_id}" class="custom-button">Bearbeiten</a></div>
            </c:forEach>
        </div>
        	<table class="transaktionen-table">
			<c:if test="${empty kontoinformationen}">
				<p>Keine Konto-Informationen gefunden.</p>
			</c:if>
			<thead>
				<tr>
					<th>IBAN</th>
					<th>Kontostand</th>
					<th>Disporahmen</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="konto" items="${kontoinformationen}">
					<tr>
						<td>${konto.IBAN}</td>
						<td><fmt:formatNumber value="${konto.kontoStand}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
						<td><fmt:formatNumber value="${konto.dispoStand}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
	</div>

<div class="transaktionen">
    <div class="form-container">
        <h2 class="form-title">Transaktion-Informationen</h2>
        <table class="transaktionen-table">
            <thead>
                <tr>
                    <th>Zahlender</th>
                    <th>Empfänger</th>
                    <th>IBAN des Empfängers</th>
                    <th>Summe</th>
                    <th>Verwendungszweck</th>
                    <th>Zeitstempel</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
					<c:when test="${empty transaktionen}">
						<tr><td colspan="6">Noch keine Transaktionen durchgeführt</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="transaktion" items="${transaktionen}">
							<c:choose>
								<c:when test="${transaktion.nach eq sessionScope.IBAN}">
									<tr>
										<td class="centered-cell">${transaktion.senderVorname} ${transaktion.senderNachname}</td>
										<td class="centered-cell">${transaktion.empfaengerVorname} ${transaktion.empfaengerNachname}</td>
                                        <td class="centered-cell"><div class="centered-content">${transaktion.von} <button class="copy-button" data-text="${transaktion.von}">Kopieren</button></div></td>
										<td><fmt:formatNumber value="${transaktion.summe}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
										<td class="verzweck-cell">${empty transaktion.verzweck ? ' - keine Angaben - ' : transaktion.verzweck}</td>
										<td><fmt:formatDate value="${transaktion.zeitstempel}" pattern="dd.MM.yyyy, HH:mm" /> Uhr</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td class="centered-cell">${transaktion.senderVorname} ${transaktion.senderNachname}</td>
										<td class="centered-cell">${transaktion.empfaengerVorname} ${transaktion.empfaengerNachname}</td>
                                        <td class="centered-cell"><div class="centered-content">${transaktion.nach} <button class="copy-button" data-text="${transaktion.nach}">Kopieren</button></div></td>
										<td><fmt:formatNumber value="${transaktion.summe}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
										<td class="verzweck-cell">${empty transaktion.verzweck ? ' - keine Angaben - ' : transaktion.verzweck}</td>
										<td><fmt:formatDate value="${transaktion.zeitstempel}" pattern="dd.MM.yyyy, HH:mm" /> Uhr</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
            </tbody>
        </table>
    </div>
</div>

</main>
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>