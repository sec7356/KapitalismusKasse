<!-- Getestet -->
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
<title>Hilfe - Kapitalismus-Kasse</title>
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
			title="Sehen Sie sich Ihr Dashboard an!">Dashboard</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp"
		title="Überweisen Sie bequem Ihr Geld!">Überweisung</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/VerlaufServlet"
		title="Sehen Sie sich alle Ihre Buchungen an!">Kontoaktivitäten</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/hilfeIntern.jsp" class="active"
		title="Holen Sie sich Hilfe!">Hilfe</a>
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
		<p>Guten Tag, ${sessionScope.vorname}  ${sessionScope.nachname}!</p>
		<p>Sie suchen nach Hilfe? Dann sind Sie hier genau richtig!</p>
	</div>
	<br>

<div class="internForm">
    <form  method="post" action="${pageContext.request.contextPath}/UpdateServlet" enctype="multipart/form-data">
        <fieldset><legend>Formular zum Problem</legend>
        <div>
            <label for="vorname">Betreff:</label><br>
            <input type="text" id="vorname" name="vorname" maxlength="30" ><br>
        </div>
        <div>
            <label for="nachname">Beschreibung:</label><br>
            <input type="text" id="nachname" name="nachname" maxlength="30" ><br>
        </div>
        <div>
            <label for="pin1">PIN:</label><br>
            <input type="password" id="pin1" name="pin1" maxlength="6" required><br>
        </div>
        
        
        <br>
        <div>
            <button name="submit" type="submit">Hilfe anfordern</button>
            <button name="reset" type="reset">Zurücksetzen</button>
        </div>
        </fieldset>
   </form>
</div>
<br>


	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
