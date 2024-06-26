<!-- Autor: Diane -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Admin Formular - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
    <script src="${pageContext.request.contextPath}/JavaScript/PinAusblenden.js"></script>
    <script src="${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
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
        <li><h1 id="adminKonsoleTitel">**Admin-Konsole**</h1></li>
        <li></li>
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
    <br><br><br><br> <!-- falsch formatiert? -->
    <p>Guten Tag, Admin!
    <br><br>Hier können Sie einen Benutzer suchen.</p>        
</div>  

<div class="Suchfeld">
    <form id="AdminSuchen" method="get" action="${pageContext.request.contextPath}/AdminBenutzerListeServlet" onsubmit="saveFormInputs()">
        <label for="vorname">Vorname:</label>
        <input type="text" id="vorname" name="vorname">
        <label for="nachname">Nachname:</label>
        <input type="text" id="nachname" name="nachname">
        <label for="email">E-Mail:</label>
        <input type="text" id="email" name="email">
        <button type="submit">Suchen</button>
    </form>
</div>
    
<div class="transaktionen">
    <table class="transaktionen-table">
        <thead>
            <tr>
                <th>Benutzer-ID</th>
                <th>Vorname</th>
                <th>Nachname</th>
                <th>E-Mail</th>
                <th>Pin</th>
                <th>Admin?</th>
                <th>Aktionen</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty konten}">
                    <tr>
                        <td colspan="7">Keine Ergebnisse!</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="konten" items="${konten}">
                        <tr>
                            <td>${konten.b_id}</td>
                            <td>${konten.vorname}</td>
                            <td>${konten.nachname}</td>
                            <td>${konten.email}</td>
                            <td class="pin-cell">
                        		<span class="pin-content">${konten.pin}</span>
                        		<span>****</span>
                    		</td>
                            <td>
                            <c:choose>
                            <c:when test="${konten.admin}"> Ja </c:when>
                            <c:otherwise>Nein</c:otherwise>
                            </c:choose>
                            </td>
                            <td>
            					<a class="action-link" href="${pageContext.request.contextPath}/BenutzerDetailsServlet?b_id=${konten.b_id}">Mehr</a>
        					</td>
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
