<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
				<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" title="Die Bank der Zukunft!">
				<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="imageMitLink"></a> 
				<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" title="Die Bank der Zukunft!" class="companyNameLink"> 
				<span>Kapitalismus-</span> <span>Kasse</span></a>
				</div>
			</li>
			<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" title="Sehen Sie sich Ihr Dashboard an!">Startseite</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" title="Überweisen Sie bequem Ihr Geld!">Überweisen</a></li>
			<li><a href="${pageContext.request.contextPath}/VerlaufServlet" class="active" title="Sehen Sie sich alle Ihre Buchungen an!">Verlauf</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" title="Ändern Sie Ihr Profilbild oder Ihre Nutzerdaten!">Benutzerverwaltung</a>
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
	<br>

	<div class="grauBackground">
		<br><br><br><br>
		<p>Guten Tag, <%=session.getAttribute("vorname")%> <%=session.getAttribute("nachname")%>!</p>
		<p>Hier können Sie alle Ihre Buchungen ansehen. Wir hoffen Sie haben viel Grünes vor Ihnen!</p>
	</div>

<div class="transaktionen">
    <table class="transaktionen-table">
        <thead>
            <tr><th>Von</th><th>Nach</th><th>Empfänger</th><th>Summe</th><th>Zeitstempel</th>                    
            </tr>
        </thead>
        <tbody>
        <c:set var="transaktionenSize" value="${transaktionen.size()}" />
            <c:choose>
                <c:when test="${empty transaktionen}">
                    <tr><td colspan="5">Noch keine Transaktionen durchgeführt</td></tr>
                </c:when>
                <c:otherwise>
                <c:forEach var="index" begin="0" end="${transaktionenSize - 1}" step="1">
            	<c:set var="reverseIndex" value="${transaktionenSize - 1 - index}" />
            	<c:set var="transaktion" value="${transaktionen[reverseIndex]}" />
                        <tr>
                            <td>${transaktion.von}</td>
                            <td>${transaktion.nach}
                            <span class="copy-button-container"><button onclick="copyToClipboardAndDisplayText('${transaktion.nach}')">Kopieren</button></span></td>
                            <td>${transaktion.vorname} ${transaktion.nachname}</td>
                            <td><fmt:formatNumber value="${transaktion.summe}" type="number" groupingUsed="true" maxFractionDigits="2" minFractionDigits="2"/>€</td>
                            <td><fmt:formatDate value="${transaktion.zeitstempel}" pattern="dd.MM.yyyy, HH:mm"/> Uhr</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
