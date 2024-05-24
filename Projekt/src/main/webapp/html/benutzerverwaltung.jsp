<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/img/favicon.ico" />
<title>KPT-Startseite - Kapitalismus-Kasse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
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
			<li><a
				href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Logout</a>
				<!-- ToDo Logout implementieren --></li>
		</ul>
	</nav>
	<br>

	<div class="grauBackground">
		<br><br><br><br>						<!-- falsch formatiert -->
		<p>Guten Tag, <%= session.getAttribute("vorname") %>!</p>
	</div>
	<br>

	<div class="internForm">
		<form action="${pageContext.request.contextPath}/UpdateServlet" method="POST" enctype="multipart/form-data">
		<fieldset><legend>Daten verwalten</legend>
			<div>
				<label for="vorname">Vorname:</label> <input type="text"
					id="vorname" name="vorname" required maxlength="30"><br>
			</div>
			<div>
				<label for="nachname">Nachname:</label> <input type="text"
					id="nachname" name="nachname" required maxlength="30"><br>
			</div>
			<div>
				<label for="password1">PIN:</label><br> <input type="password"
					id="pin1" name="pin1" required maxlength="8"><br>
			</div>
			<div>
				<label for="password2">PIN bestätigen:</label><br> <input
					type="password" id="pin2" name="pin2" required maxlength="8"><br>
			</div>
			<div>
				<label for="profilbild">Profilbild:</label> <input type="file"
					id="profilbild" name="profilbild" accept="image/*"><br>
			</div>
			<div>
				<button name="submit" type="submit">Änderungen speichern</button>
				<button name="reset" type="reset">Zurücksetzen</button>
			</div>
			</fieldset>
		</form>

		<form action="${pageContext.request.contextPath}/LoeschenServlet"
			method="POST">
			<div>
				<p>Profil löschen:</p>
				<button name="loeschen" type="submit">Löschen</button>
				<br>
			</div>
		</form>
	</div>
	</div>

	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
	</footer>
</body>
</html>
