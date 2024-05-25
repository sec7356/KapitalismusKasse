<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Kontoauszüge - Kapitalismus-Kasse</title>
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
		<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp">Startseite</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp">Überweisungen</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Kontoauszuege.jsp"  class="active">Kontoauszüge</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp">Benutzerverwaltung</a>
		</li>
		<li>
			<form  method="post" action="${pageContext.request.contextPath}/LogoutServlet">
				<button name="loeschen" type="submit">Logout</button>
			</form>
		</li>
	</ul>
</nav>

<div class="grauBackground">
	<br><br><br><br>												<!-- falsch formatiert -->
	<p>Guten Tag, <%= session.getAttribute("vorname") %> <%= session.getAttribute("nachname") %>!</p>		
	
	<div class="kontostand">
		<p>IBAN und Kontostand</p>
		<p><%= session.getAttribute("IBAN") %> <br> <%= session.getAttribute("kontostand") %></p>
    </div>
</div>

		<!-- ToDo -->


<footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>