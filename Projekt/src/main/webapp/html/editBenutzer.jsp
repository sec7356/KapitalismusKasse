<!-- Autor: @Can -->
<!-- Validiert am 03.07 -->

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
<script src="${pageContext.request.contextPath}/JavaScript/navigation_admin.js"></script>
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

<br>
<div class="grauBackground">
		<br><br><br>						
		<div class="profile-text">
				<p id="greeting">
					Guten Tag, <span id="name">Admin</span>
				</p>
		</div>
		<p>Hier können Sie den Vor- und Nachnamen, die PIN oder ändern oder auch dem Nutzer die Admin-Rolle geben!</p>
	</div>
	<br>
<div class="grauBackground">    
    <a href="${pageContext.request.contextPath}/AdminBenutzerListeServlet">Zurück zur Benutzersuche</a>
</div>

	<div class="transaktionen">
    <div class="form-container">
        <h2 class="form-title">Bearbeitung: Benutzer-Informationen</h2>        
        <form action="${pageContext.request.contextPath}/EditBenutzerServlet" method="post" class="form" id="editBenutzerForm">
            <span class="form-submit">
                <input type="submit" class="custom-button" value="Speichern">
            </span>
        <table class="transaktionen-table">
                <tr>
                    <th>Vorname</th>
                    <th>Nachname</th>
                    <th>Email</th>
                    <th>PIN</th>
                    <th>Admin</th>
                </tr>
                <tr>
                    <td><input type="text" id="vorname" name="vorname" value="${empty benutzer ? '' : benutzer.vorname}" required maxlength="49"></td>
					<td><input type="text" id="nachname" name="nachname" value="${empty benutzer ? '' : benutzer.nachname}" required maxlength="49"></td>
                    <td>${empty benutzer ? '' : benutzer.email}</td>
                    <td><input type="text" id="pin" name="pin" pattern="[0-9]{1,6}" value="${empty benutzer ? '' : benutzer.pin}" required maxlength="6" title="Bitte geben Sie nur bis zu 6 Ziffern ein."></td>
                    <td><select id="admin" name="admin" required>
                            <c:choose>
                                <c:when test="${sessionScope.b_id == benutzer.b_id}">
                                    <option value="" disabled>Admin-Rolle ändern</option>
                                    <option value="true" selected>Ja (nicht änderbar)</option>
									<option value="false" disabled>Nein</option>
                                    
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${empty benutzer or benutzer.admin}">
											<option value="" disabled>Admin-Rolle ändern</option>
                                            <option value="true" selected>Ja</option>
                                            <option value="false">Nein</option>
                                        </c:when>
                                        <c:otherwise>
                      						<option value="" disabled>Admin-Rolle ändern</option>
                                            <option value="true">Ja</option>
                                            <option value="false" selected>Nein</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                    </select>
                </td>
                </tr>
        </table>
        <input type="hidden" name="b_id" value="${benutzer.b_id}">
    </form>
</div>
</div>

	
	<div class="transaktionen">
    	<div class="form-container">
            <h2 class="form-title">Konto-Informationen</h2>
        	<table class="transaktionen-table">
			<c:if test="${empty kontoinformationen}">
				<tr><td colspan="3">Keine Konto-Informationen gefunden</td></tr>
			</c:if>
				<tr>
					<th>IBAN</th>
					<th>Kontostand</th>
					<th>Disporahmen</th>
				</tr>
				<c:forEach var="konto" items="${kontoinformationen}">
					<tr>
						<td>${konto.IBAN}</td>
						<td><fmt:formatNumber value="${konto.kontoStand}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
						<td><fmt:formatNumber value="${konto.dispoStand}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	


<div class="transaktionen">
    <div class="form-container">
        <h2 class="form-title">Transaktion-Informationen</h2>
        <table class="transaktionen-table">
                <tr>
                    <th>Zahlender</th>
                    <th>Empfänger</th>
                    <th>IBAN des Empfängers</th>
                    <th>Summe</th>
                    <th>Verwendungszweck</th>
                    <th>Zeitstempel</th>
                </tr>
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
        </table>
    </div>
</div>
	




	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
