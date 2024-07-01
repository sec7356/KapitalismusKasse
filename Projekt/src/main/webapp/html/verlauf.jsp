<!-- Autor: @Selim, @Can -->
<!-- Validiert -->

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
	<script src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
	<script src="${pageContext.request.contextPath}/JavaScript/Zwischenablage.js"></script>
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
			<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" title="Sehen Sie sich Ihr Dashboard an!">Dashboard</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" title="Überweisen Sie bequem Ihr Geld!">Überweisung</a></li>
			<li><a href="${pageContext.request.contextPath}/VerlaufServlet" class="active" title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a></li>
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

	<div class="grauBackground">
			<br><br><br><br><br>						
		<div class="profile-text">
				<p id="greeting">
					Guten Tag, <span id="vorname">${sessionScope.vorname}</span>
					<span id="nachname">${sessionScope.nachname}</span>
				</p>
		</div>
		<p>Hier können Sie alle Ihre Buchungen ansehen. Wir hoffen Sie haben viel Grünes vor Ihnen!</p>
	</div>

	<div class="transaktionen">
		<table class="transaktionen-table">
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
						<tr><td colspan="6">Noch keine Transaktionen durchgeführt</td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="transaktion" items="${transaktionen}">
							<c:choose>
								<c:when test="${transaktion.nach eq sessionScope.IBAN}">
									<tr>
										<td class="centered-cell">${transaktion.senderVorname} ${transaktion.senderNachname}</td>
                                        <td class="empty-cell">-</td>
                                        <td class="centered-cell"><div class="centered-content">${transaktion.von} <button class="copy-button" onclick="copyToClipboardAndDisplayText('${transaktion.von}')">Kopieren</button></div></td>
										<td class="summe-positive">+ <fmt:formatNumber value="${transaktion.summe}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
										<td class="verzweck-cell">${empty transaktion.verzweck ? ' - keine Angaben - ' : transaktion.verzweck}</td>
										<td><fmt:formatDate value="${transaktion.zeitstempel}" pattern="dd.MM.yyyy, HH:mm" /> Uhr</td>
									</tr>
								</c:when>
								<c:otherwise>
									<tr>
                                        <td class="empty-cell">-</td>
										<td>${transaktion.empfaengerVorname} ${transaktion.empfaengerNachname}</td>
                                        <td class="centered-cell"><div class="centered-content">${transaktion.nach} <button class="copy-button" onclick="copyToClipboardAndDisplayText('${transaktion.nach}')">Kopieren</button></div></td>
										<td class="summe-negative">- <fmt:formatNumber value="${transaktion.summe}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
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
</main>

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>