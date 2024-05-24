<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Admin Formular - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
</head>
<body>

<nav id="navbar">
	<ul>
		<li>
			<div class="container">
				<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="image">
				<div class="company-name">
   	 				<span>Kapitalismus-</span>
    				<span>Kasse</span>
    			</div>
    		</div>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Logout</a>
		</li>
	</ul>
</nav>
<br>

<div class="grauBackground">
	<br><br><br><br>												<!-- falsch formatiert? -->
	<p>Guten Tag, <%= session.getAttribute("vorname") %>!</p>		
</div>
<br>
    <div class="internForm">
        <form method="post" action="${pageContext.request.contextPath}/AdminSuchtBenutzerServlet">
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
    </div>
    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>