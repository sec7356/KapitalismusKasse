<!-- Validiert -->
<!-- Autor: Diane -->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
<title>Benutzerverwaltung - Kapitalismus-Kasse</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
<script src="${pageContext.request.contextPath}/JavaScript/popup.js" defer></script>
<script  src= "${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
<script  src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
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
            <li><a href="${pageContext.request.contextPath}/VerlaufServlet" title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a></li>
            <li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp" title="Holen Sie sich Hilfe!">Hilfe</a>
            </li>
            <li class="no-hover">
			<a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" title="Nutzerdaten verwalten"> 
				<img src="${pageContext.request.contextPath}/img/accountBildFokus.jpg"	alt="Benutzerverwaltung" class="accountBild"></a>
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
	<br>

		

	<div class="grauBackground">
		<br><br><br><br>						
		<div class="profile-text">
				<p id="greeting">
					Guten Tag, <span id="vorname">${sessionScope.vorname}</span>
					<span id="nachname">${sessionScope.nachname}</span>
				</p>
		</div>
				<p>Hier können Sie Ihren Vornamen, Nachnamen und PIN ändern, sowie ein Profilbild hinzufügen!</p>
		
	</div>
	<br>

<div class="internForm">
    <form  method="post" action="${pageContext.request.contextPath}/UpdateServlet" enctype="multipart/form-data">
        <fieldset><legend>Benutzerdaten verwalten</legend>
			<div>
        	<br>
            <label for="neuerVorname">Vorname</label><br>
            <input type="text" id="neuerVorname" name="neuerVorname" maxlength="30" ><br>
        </div>
        <div>
            <label for="neuerNachname">Nachname</label><br>
            <input type="text" id="neuerNachname" name="neuerNachname" maxlength="30" ><br>
        </div>
        <div>
            <label for="neuepin1">PIN</label><br>
            <input type="password" id="neuepin1" name="neuepin1" maxlength="6" ><br>
        </div>
        <div>
            <label for="neuepin2">PIN bestätigen</label><br>
            <input type="password" id="neuepin2" name="neuepin2" maxlength="6" ><br>            
        </div>
        <div>
        	<br>
        	 <div class="error-message-container">
             	<c:if test="${not empty sessionScope.errorMessage}">                
                    <div>${sessionScope.errorMessage}</div>
                    <c:remove var="errorMessage" scope="session"/>
        		</c:if>        
			</div>
            <label for="profilbild">Profilbild:</label>            
            <input type="file" id="profilbild" name="profilbild" accept="image/*"><br>
            <span class="info-fields">(Das Profilbild darf maximal 1 MB betragen)</span>
            
        </div>
        <br>
        <div>
            <button name="submit" type="submit">Änderungen speichern</button>
            <button name="reset" type="reset">Zurücksetzen</button>
        </div>
        </fieldset>
   </form>
</div>
<br>
<div class="internForm">
        <form action="${pageContext.request.contextPath}/LoeschenServlet" method="POST">
        <fieldset><legend>Account verwalten</legend>
        	<div>
                <p>Profil löschen:</p>
                <button name="loeschen" type="submit">Löschen</button><br> 
       	 </div>
        </fieldset>
   		</form>
</div>


<div id="popup" class="popup">
    <p id="popupMessage" class="popup-message"></p>
    <button onclick="hidePopup()" class="popup-button">Verstanden!</button>
</div>

<input type="hidden" id="showMessage" value="${not empty requestScope.showMessage ? requestScope.showMessage : 'false'}">
<input type="hidden" id="errorMessage" value="${not empty requestScope.errorMessage ? requestScope.errorMessage : ''}">
<input type="hidden" id="successMessage" value="${not empty requestScope.successMessage ? requestScope.successMessage : ''}">

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
