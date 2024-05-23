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
		<li><a href="UserStartseite.jsp" class="active">Startseite</a>
		</li>
		<li><a href="Ueberweisungen.jsp">Überweisungen</a>
		</li>
		<li><a href="benutzerverwaltung.jsp">Benutzerverwaltung</a>
		</li>
		<li><a href="Banking-Login.jsp">Logout</a>
		</li>
	</ul>
</nav>
<br>
	<div id="div_name">
   		<h1>§{sessionScope.name} ${4sessionScope.nachname}</h1>
   		<p>${sessionScope.email}</p>
   	</div>
   <!-- To-Do: 
   			- Konto & Kontostand anzeigen lassen
   			- Link zu einer Seite, wo man ÜÜberweisungen tätigen kann
   			- Link zu benutzerverwaltung.jsp einfügen -->
   
<footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>