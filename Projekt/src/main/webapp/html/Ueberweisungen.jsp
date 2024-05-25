<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Überweisen - Kapitalismus-Kasse</title>
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
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" class="active">Überweisen</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/verlauf.jsp">Verlauf</a>
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
   
   <!-- To-Do: 
   			- Konto & Kontostand anzeigen lassen -->
   			
<div class="grauBackground">
	<br><br><br><br>												<!-- falsch formatiert -->
	<p>Guten Tag, <%= session.getAttribute("vorname") %> <%= session.getAttribute("nachname") %>!</p>		
	
	<div class="kontostand">
		<p>IBAN und Kontostand</p>
		<p><%= session.getAttribute("IBAN") %> <br> <%= session.getAttribute("kontostand") %></p>
    </div>
</div>
	<!-- Überweisung tätigen -->
	<div class="geldHintergrund">
	<div class="internForm">
		<form method="post"
			action="${pageContext.request.contextPath}/UeberweisenServlet">
			<fieldset>
				<legend>Überweisen</legend>
				<div>
					<label for="von">Von:</label>  <%= session.getAttribute("IBAN") %>
				</div>
				<div>
					<label for="nach">Nach:</label> <input type="text" id="nach"
						name="nach" required maxlength="34"><br>
				</div>
				<div>
					<label for="summe">Summe:</label> <input type="number" id="summe"
						name="summe" required step="0.01" min="0" max="9999999999999.99"><br>
				</div>
				<div>
					<button name="submit" type="submit">Überweisen</button>
					<button name="reset" type="reset">Zurücksetzen</button>
				</div><br>
			</fieldset>
		</form>

	</div>
	
	<br>
	
	<!-- Alle Überweisungen ansehen von verlauf.jsp -->
	<div class="internForm">
		<form method="post"
			action="${pageContext.request.contextPath}/html/verlauf.jsp">
			<fieldset>
				<legend>Letzte Überweisungen</legend>
				
				<p>Sehen Sie sich all Ihre Überweisungen an!</p>
				<div>
					<button name="submit" type="submit">Verlauf anzeigen</button>
				</div><br>
			</fieldset>
		</form>

	</div>
	
</div>
	<footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>