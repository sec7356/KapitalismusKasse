<!-- Autor: Can - Logik mit der Prüfung der Transaktionstabelle mit ChatGPT -->

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
					Guten Tag, <span id="vorname">Admin</span>
				</p>
		</div>
		<p>Hier können Sie den Kontostand oder auch das Disporahmen nach Ihrer Wahl frei entscheiden!</p>
	</div>
	<br>
<div class="grauBackground">    
    <a href="${pageContext.request.contextPath}/AdminBenutzerListeServlet">Zurück zur Benutzersuche</a>
</div>

<div class="transaktionen">
    <div class="form-container">
        <h2 class="form-title">Benutzer-Informationen</h2>
	        <table class="transaktionen-table">
            <tr>
                <th>Vorname</th>
                <th>Nachname</th>
                <th>Email</th>
                <th>PIN</th>
                <th>Admin</th>
            </tr>
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
    		</table>
    </div>
</div>


<div class="transaktionen">
    <div class="form-container">
        <h2 class="form-title">Bearbeitung: Konto-Informationen</h2>        
            <form action="${pageContext.request.contextPath}/EditKontoServlet" method="post" class="form" id="editBenutzerForm">
    		<span class="form-submit">
                <input type="submit" class="custom-button" value="Speichern">
            </span>
        
            <table class="transaktionen-table">
                    <tr>
                        <th>IBAN</th>
                        <th>Kontostand</th>
                        <th>Disporahmen</th>
                    </tr>
                    <tr>
                        <td>${konto.IBAN}</td> <!-- IBAN als nicht bearbeitbares Feld -->
                        <td><input type="number" id="kontoStand" name="kontoStand" value="${empty konto ? '' : konto.kontoStand}" required min="0" max="9999999999999"></td>
                        <td><input type="number" id="dispoStand" name="dispoStand" value="${empty konto ? '' : konto.dispoStand}" required min="0" max="99999999"></td>
                    </tr>
            </table>
			<input type="hidden" name="b_id" value="${benutzer.b_id}">
			<input type="hidden" name="iban" value="${konto.IBAN}">
			</form>
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
