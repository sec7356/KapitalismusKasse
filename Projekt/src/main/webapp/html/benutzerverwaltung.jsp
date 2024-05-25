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
	
</head>
<body>

	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<img src="${pageContext.request.contextPath}/img/logo.jpg"
						alt="Logo" class="image">
					<div class="company-name">
						<span>Kapitalismus-</span> <span>Kasse</span>
					</div>
				</div>
			</li>
			<li><a
				href="${pageContext.request.contextPath}/html/UserStartseite.jsp">Startseite</a>
			</li>
			<li><a
				href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp">Überweisungen</a>
			</li>
			<li><a
				href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp"
				class="active">Benutzerverwaltung</a></li>
			<li>
				<form  method="post" action="${pageContext.request.contextPath}/LogoutServlet">
					<button name="loeschen" type="submit">Logout</button>
				</form>
			</li>
		</ul>
	</nav>
	<br>

	<div class="grauBackground">
		<br><br><br><br>						<!-- falsch formatiert -->
		<p>Guten Tag, <%= session.getAttribute("vorname") %>!</p>
	</div>
	<br>

	<div class="internForm">
    <form  method="post" action="${pageContext.request.contextPath}/UpdateServlet">
        <fieldset><legend>Benutzerdaten verwalten</legend>
        <div>
            <label for="vorname">Vorname:</label><br>
            <input type="text" id="vorname" name="vorname" required maxlength="30"><br>
        </div>
        <div>
            <label for="nachname">Nachname:</label><br>
            <input type="text" id="nachname" name="nachname" required maxlength="30"><br>
        </div>
        <div>
            <label for="pin1">PIN:</label><br>
            <input type="password" id="pin1" name="pin1" required maxlength="6"><br>
        </div>
        <div>
            <label for="pin2">PIN bestätigen:</label><br>
            <input type="password" id="pin2" name="pin2" required maxlength="6"><br>
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
	<br>
    <form action="${pageContext.request.contextPath}/LoeschenServlet" method="POST">
         <fieldset><legend>Benutzerdaten löschen</legend>
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

<%-- Setze die Werte der versteckten Felder basierend auf den Attributen --%>
<input type="hidden" id="showMessage" value="<%= request.getAttribute("showMessage") != null ? request.getAttribute("showMessage") : "false" %>">
<input type="hidden" id="errorMessage" value="<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>">





	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
