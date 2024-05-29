<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Überweisen - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleIntern.css">
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
		title="Sehen Sie sich Ihr Dashboard an!">Startseite</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp" class="active"
		title="Überweisen Sie bequem Ihr Geld!">Überweisen</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/verlauf.jsp"
		title="Sehen Sie sich alle Ihre Buchungen an!">Verlauf</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/benutzerverwaltung.jsp"
		title="Ändern Sie Ihr Profilbild oder Ihre Nutzerdaten!">Benutzerverwaltung</a>
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
						name="summe" required step="0.01" min="0" max="9999999999999.99"  maxlength=""><br>
				</div><br>
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