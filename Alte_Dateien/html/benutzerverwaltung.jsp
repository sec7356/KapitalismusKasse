<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="fehlermeldungAllgemein.jsp" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="../img/favicon.ico" />
    <title>KPT-Startseite - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<nav id="navbar">
	<ul>
		<li>
			<div class="container">
				<img src="../img/logo.jpg" alt="Logo" class="image">
				<div class="company-name">
   	 				<span>Kapitalismus-</span>
    				<span>Kasse</span>
    			</div>
    		</div>
		</li>
		<li><a href="UserStartseite.jsp">Startseite</a>
		</li>
		<li><a href="Ueberweisungen.jsp">Überweisungen</a>
		</li>
		<li><a href="benutzerverwaltung.jsp" class="active">Benutzerverwaltung</a>
		</li>
		<li><a href="Banking-Login.jsp">Logout</a>
		</li>
	</ul>
</nav>
<br>

<div class="login_window">
        <div class="login-form">
        <div class="background-image"></div>
        <form action="../UpdateServlet" method="POST" enctype="multipart/form-data"> <!-- action fehlt -->
            <div>
                <label for="vorname">Vorname:</label>
                <input type="text" id="vorname" name="vorname" required maxlength="30"><br>          <!-- mit Daten aus DB vorbelegen z.B. value= request.getParameter("vorname") -->
            </div>
            <div>
                <label for="nachname">Nachname:</label>
                <input type="text" id="nachname" name="nachname" required maxlength="30"><br>               <!-- mit Daten aus DB vorbelegen -->
            </div>
            <div>
                <label for="password1">PIN:</label><br>
                <input type="password" id="pin1" name="pin1" required maxlength="8"><br>
            </div>
            <div>
                <label for="password2">PIN bestätigen:</label><br>
                <input type="password" id="pin2" name="pin2" required maxlength="8"><br>
            </div>
            <div>
                <label for="profilbild">Profilbild:</label>
                <input type="file" id="profilbild" name="profilbild" accept="image/*"><br>
            </div>
            <div>
				 <button name="submit" type="submit">Änderungen speichern</button>
				 <button name="reset" type="reset">Zurücksetzen</button>
			</div>
        </form>
	</div>
 </div>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
