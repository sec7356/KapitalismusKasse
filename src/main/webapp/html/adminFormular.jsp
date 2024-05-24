<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>KPT-Startseite - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
	<header>
        <h1>Admin-Benutzerverwaltung</h1>
    </header>
	<nav>    
        <ul>
            <li><a href="Banking-Login.jsp" class="white-anchor">Logout</a></li>   <!-- geeignetes Logout implementieren -->
            <li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" class="white-anchor">Überweisungen</a></li>         <!-- Link zur Überweisungs-seite einfügen -->
        </ul>
    </nav>
    <article>
        <form id="myForm" method="post" action="AdminSuchtBenutzerServlet">
			<fieldset><legend>Benutzer suchen</legend>
				<div>
                	<label for="vorname">Vorname:</label>
                	<input type="text" id="vorname" name="vorname" required maxlength="30"><br>          <!-- mit Daten aus DB vorbelegen z.B. value= request.getParameter("vorname") -->
            	</div>
            	<div>
                	<label for="nachname">Nachname:</label>
                	<input type="text" id="nachname" name="nachname" required maxlength="30"><br>               <!-- mit Daten aus DB vorbelegen -->
           	 	</div>
				<div>
				  <button name="submit" type="submit">Benutzer suchen</button>
				  <button name="reset" type="reset">Zurücksetzen</button>
				</div>
			</fieldset>
		</form>
    </article>
    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>