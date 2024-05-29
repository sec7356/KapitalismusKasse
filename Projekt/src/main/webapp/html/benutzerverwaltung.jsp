<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/img/favicon.ico" />
<title>Benutzerverwaltung - Kapitalismus-Kasse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/styleIntern.css">
<script src="${pageContext.request.contextPath}/JavaScript/popup.js" defer></script>
<script  src= "${pageContext.request.contextPath}/JavaScript/Countdown.js"></script>
<script  src="${pageContext.request.contextPath}/JavaScript/greeting.js"></script>
	
</head>
<body>

	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
					title="Die Bank der Zukunft!">
					<img src="${pageContext.request.contextPath}/img/logo.jpg"
						alt="Logo" class="imageMitLink"></a>
					
					<a href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
					title="Die Bank der Zukunft!" class="companyNameLink">
						<span>Kapitalismus-</span>
						<span>Kasse</span></a>
					
				</div>
			</li>
			<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp"
			title="Sehen Sie sich Ihr Dashboard an!">Startseite</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp"
		title="Überweisen Sie bequem Ihr Geld!">Überweisen</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/verlauf.jsp"
		title="Sehen Sie sich alle Ihre Buchungen an!">Verlauf</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" class="active"
		title="Ändern Sie Ihr Profilbild oder Ihre Nutzerdaten!">Benutzerverwaltung</a>
		</li>
		<li> <!-- Benutzer verwalten Icon -->
        	<a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp" title="Nutzerdaten verwalten">
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
	<br>

	<div class="grauBackground">
		<br><br><br><br>						
		<p>Guten Tag, <%= session.getAttribute("vorname")%>  <%= session.getAttribute("nachname") %>!</p>
	</div>
	<br>

<div class="internForm">
    <form  method="post" action="${pageContext.request.contextPath}/UpdateServlet" enctype="multipart/form-data">
        <fieldset><legend>Benutzerdaten verwalten</legend>
        <div>
            <label for="vorname">Vorname:</label><br>
            <input type="text" id="vorname" name="vorname" maxlength="30" ><br>
        </div>
        <div>
            <label for="nachname">Nachname:</label><br>
            <input type="text" id="nachname" name="nachname" maxlength="30" ><br>
        </div>
        <div>
            <label for="pin1">PIN:</label><br>
            <input type="password" id="pin1" name="pin1" maxlength="6" required><br>
        </div>
        <div>
            <label for="pin2">PIN bestätigen:</label><br>
            <input type="password" id="pin2" name="pin2" maxlength="6" required><br>
        </div>
        <div>
            <label for="profilbild">Profilbild:</label>
            <input type="file" id="profilbild" name="profilbild" accept="image/*"><br>
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


<!-- Hier wird die Popup-Nachricht angezeigt -->
<div id="popup" class="popup">
    <p id="popupMessage" class="popup-message"></p>
    <button onclick="hidePopup()" class="popup-button">Verstanden!</button>
</div>

<!-- Setze die Werte der versteckten Felder basierend auf den Attributen -->
<input type="hidden" id="showMessage" value="<%= request.getAttribute("showMessage") != null ? request.getAttribute("showMessage") : "false" %>">
<input type="hidden" id="errorMessage" value="<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>">
<input type="hidden" id="successMessage" value="<%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>">

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
