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
    <form method="post" action="${pageContext.request.contextPath}/AdminSetztAdminsServlet">
        <fieldset>
            <legend>Benutzer als Admin setzen</legend>
            <div>
                <label for="vorname">Vorname: ${benutzer.vorname}</label>
            </div>
            <div>
                <label for="nachname">Nachname: ${benutzer.nachname}</label>
            </div>
            <div>
                <label for="email">Email: ${benutzer.email}</label>
            </div>
            <div>
                <label for="admin">Admin:</label>
                <input type="checkbox" id="admin" name="admin">
            </div>
            <div>
                <button name="submit" type="submit">Admin setzen</button>
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