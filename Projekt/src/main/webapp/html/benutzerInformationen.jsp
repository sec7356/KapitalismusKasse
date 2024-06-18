<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
<title>Alle Buchungen - Kapitalismus-Kasse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styleIntern.css">
<script src="${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/Zwischenablage.js"></script>

</head>
<body>
	<nav id="navbar">
    <ul>
        <li>
            <div class="container">
                <a href="${pageContext.request.contextPath}/AdminBenutzerListeServlet" title="Die Bank der Zukunft!"> 
                    <img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="imageMitLink">
                </a> 
                <a href="${pageContext.request.contextPath}/html/adminFormular.jsp" title="Die Bank der Zukunft!" class="companyNameLink">
                    <span>Kapitalismus-</span> <span>Kasse</span>
                </a>
            </div>
        </li>
        <li><a href="${pageContext.request.contextPath}/AdminBenutzerListeServlet" class="active" title="Suchen sie einen bestimmten Nutzer!">Benutzersuche</a></li>
        <li><a href="${pageContext.request.contextPath}/html/adminSetzen.jsp" title="Setzen sie den Status anderer Nutzer!">Adminverwaltung</a></li>
        <li>
            <!-- Benutzer verwalten Icon --> 
            <a href="${pageContext.request.contextPath}/html/benutzerverwaltungAdmin.jsp" title="Nutzerdaten verwalten"> 
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
<br><br><br>
<main>
<br>
<div class="grauBackground">
	<br>
    <p>Guten Tag, Admin!
    <br><br>Hier können Sie einen Benutzer suchen.</p>  
</div>
<br>
<div class="grauBackground">    
    <a href="${pageContext.request.contextPath}/AdminBenutzerListeServlet">Zurück zur Benutzersuche</a>
</div>

	<div class="transaktionen">
	<table class="transaktionen-table">
	<h2>Benutzer-Informationen</h2>
    <c:if test="${empty benutzerinformationen}">
        <p>Keine Benutzerinformationen gefunden.</p>
    </c:if>
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
                    <td>${benutzer.admin}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    
    <div class="transaktionen">
	<table class="transaktionen-table">
	<h2>Konto-Informationen</h2>
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
                    <td>${konto.kontoStand}</td>
                    <td>${konto.dispoStand}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

	</div>


	<div class="transaktionen">
		<table class="transaktionen-table">
			<h2>Transaktion-Informationen</h2>
		
			<thead>
				<tr>
					<th>Zahlender</th>
					<th>Empfänger</th>
					<th>IBAN</th>
					<th>Summe</th>
					<th>Verwendungszweck</th>
					<th>Zeitstempel</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty transaktionen}">
						<tr> <td colspan="6">Keine Transaktionen durchgeführt</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="transaktion" items="${transaktionen}">
							<c:choose>
								<c:when test="${transaktion.nach eq sessionScope.IBAN}">
									<tr>
										<td>${transaktion.senderVorname} ${transaktion.senderNachname}</td>
										
										<td style="text-align: center;">-</td>
										
										<td> ${transaktion.von} <button class="copy-button" onclick="copyToClipboardAndDisplayText('${transaktion.von}')">Kopieren</button></td>
										
										<td> <fmt:formatNumber
												value="${transaktion.summe}" type="number"
												groupingUsed="true" maxFractionDigits="2"
												minFractionDigits="2" /> €
										</td>
										<td class="verzweck-cell">${empty transaktion.verzweck ? ' - keine Angaben - ' : transaktion.verzweck}</td>
										
										<td><fmt:formatDate value="${transaktion.zeitstempel}"
												pattern="dd.MM.yyyy, HH:mm" /> Uhr</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
										<td style="text-align: center;">-</td>
											
										<td>${transaktion.empfaengerVorname} ${transaktion.empfaengerNachname}</td>
											
										<td>${transaktion.nach} <button class="copy-button" onclick="copyToClipboardAndDisplayText('${transaktion.nach}')">Kopieren</button></td>
										
										<td><fmt:formatNumber value="${transaktion.summe}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
										<td class="verzweck-cell">${empty transaktion.verzweck ? ' - keine Angaben - ' : transaktion.verzweck}</td>
										
										<td><fmt:formatDate value="${transaktion.zeitstempel}"
												pattern="dd.MM.yyyy, HH:mm" /> Uhr</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>


		</table>
	</div>

</main>
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>