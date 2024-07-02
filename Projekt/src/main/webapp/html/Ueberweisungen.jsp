<!-- Autor: Can -->
<!-- FEHLERMELDUNG: "The value of the for attribute of the label element must be the ID of a non-hidden form control."! -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <script src="${pageContext.request.contextPath}/JavaScript/Verwendungszweck.js"></script>
    <script src="${pageContext.request.contextPath}/JavaScript/eingabeUeberweisung.js"></script>
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
            <li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" class="active" title="Überweisen Sie bequem Ihr Geld!">Überweisung</a></li>
            <li><a href="${pageContext.request.contextPath}/VerlaufServlet" title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a></li>
            <li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp" title="Holen Sie sich Hilfe!">Hilfe</a>
            </li>
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
        <form method="post" action="${pageContext.request.contextPath}/UeberweisungUeberpruefenServlet" id="ueberweisungForm" accept-charset="UTF-8">
            <section>
                <fieldset class="account-info-container">
                    <legend>Ihr Konto</legend>
                    <div class="account-info">
                        <div class="iban-info">
                            <label>IBAN:</label>
                            <span>${sessionScope.formattedIban}</span>
                        </div>
                        <div class="saldo-info">
                            <label>Aktueller Kontosaldo:</label>
                            <span>
                                <fmt:formatNumber value="${sessionScope.kontostand}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2" /> €
                            </span>
                        </div>
                    </div>
                </fieldset>
                <div class="new-transfer-header-container">
                    <h2 class="new-transfer-header">Echtzeit-<br>Überweisung</h2>
                    <div class="progress-container">
                        <div class="step">1</div>
                        <div class="step-description">Erfassung</div>
                    </div>
                    <div class="progress-container">
                        <div class="step second-step">2</div>
                        <div class="step-description-2">Prüfen &amp; Bestätigen</div>
                    </div>
                    <div class="progress-container">
                        <div class="step second-step">3</div>
                        <div class="step-description-2">Abschluss</div>
                    </div>
                </div>
                <fieldset>
                    <legend>Empfängerdaten</legend>
                    <div class="form-group">
                        <label for="nach">IBAN*</label>
                        <input type="text" id="nach" name="nach" required pattern=".{22,}" title="Die IBAN muss mindestens 22 Zeichen lang sein" maxlength="22">
                        <span class="icon" id="nach-icon"></span>
                    </div>
                    <div class="error-message-container">
                      <!-- Container für Fehlermeldung -->
                      <c:if test="${not empty sessionScope.error}">
                          <div class="message error-message">
                              ${sessionScope.error}
							  <c:remove var="error" scope="session"/>
                          </div>
                      </c:if>
                    </div>
                </fieldset>
                <fieldset>
                    <legend>Zahlungsdaten</legend>
                    <div class="form-group">
                        <label for="summe">Betrag* EUR</label>
                        <input type="number" id="summe" name="summe" required min="1" max="9999999999999.99" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1')">
                        <!-- JS: erlaubt sind nur nur numerische Zeichen & 1 Dezimalpunkt - replace1 entfernt alles was keine Ziffern/Punkte sind, replace2 stellt sicher, dass nur ein Dezimalpunkt vorkommt -->
                        <span class="icon" id="summe-icon"></span>
                    </div>
                    <div class="form-group">
					<label></label>
                        <p class="hint-text">
							Bitte beachten Sie eventuell die Meldepflicht ab 12.500 Euro <br>gemäß
							<a href="https://www.bundesbank.de/de/service/meldewesen/aussenwirtschaft" target="blank">Außenwirtschaftsverordnung<img src="${pageContext.request.contextPath}/img/Link.png" alt="Logo" class="link-logo"></a>
						</p>
                    </div>
                    <div class="form-group">
                        <label for="verwendungszweck">Verwendungszweck</label>
                        <textarea id="verwendungszweck" name="verwendungszweck" maxlength="140"></textarea>
                    </div>
                    <div class="form-group">
                   	<label></label> 
                        <div id="char-count" class="hint-text">Sie können noch 140 Zeichen eingeben.</div>
                    </div>
                    <br><br>
                    <div class="form-group">
                    	<label>Hinweis</label>
                        <p class="hint-text">
                            Wir möchten Sie darauf hinweisen, dass Überweisungen
                            ausschließlich an Empfänger durchgeführt werden können, die
                            ebenfalls Kunden der Kapitalismus-Kasse sind.<br><br>
                            Dies gewährleistet die Sicherheit und Effizienz unserer
                            Transaktionen innerhalb unseres Instituts.
                        </p>
                    </div>

                    <div class="form-group">
                        <label>*Pflichtfelder</label>
                    </div>
                </fieldset>
                <div class="button-container">
                    <button name="reset" id="resetZeichen" type="reset">Zurücksetzen</button>
                    <button name="submit" type="submit">Weiter</button>
                </div>
            </section>
        </form>
    </main>
    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>

</body>
</html>
