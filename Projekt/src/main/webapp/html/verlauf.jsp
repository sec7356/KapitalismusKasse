<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Alle Buchungen - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
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
		<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp">Startseite</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp">Überweisen</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/verlauf.jsp" class="active">Verlauf</a>
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
<br>
      			
<div class="grauBackground">
	<br><br><br><br>												
	<p>Guten Tag, <%= session.getAttribute("vorname") %> <%= session.getAttribute("nachname") %>!</p>
	<p>Hier können Sie alle Ihre Buchungen ansehen. Wir hoffen Sie haben viel Grünes vor Ihnen!</p>		
</div>

   <!-- Hier alle Überweisungen des Kontos als Liste anzeigen -->

	<footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>