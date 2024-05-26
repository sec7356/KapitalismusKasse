<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Startseite - Kapitalismus-Kasse</title>
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
		<li><a href="${pageContext.request.contextPath}/html/UserStartseite.jsp" class="active">Startseite</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp">Überweisen</a>
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

<div class="grauBackground">
	<br><br><br><br>											
	<p>Guten Tag, <%= session.getAttribute("vorname") %> <%= session.getAttribute("nachname") %>!</p>		
	
	<div class="profilbild">
        <p>Profilbild:</p>
        <img src="${pageContext.request.contextPath}/DisplayImageServlet" alt="Profilbild" />
    </div>
	
	<div class="kontostand">
		<p>IBAN und Kontostand</p>
		<p><%= session.getAttribute("IBAN") %> <br> <%= session.getAttribute("kontostand") %></p>
    </div>
</div>

<div class="aktionen">
	<h2>Was möchtest du machen?</h2>
	<br>
	<div class="aktion">
		<a href="${pageContext.request.contextPath}/html/Ueberweisungen.jsp">Geld überweisen</a>
	</div>
	<div class="aktion">
		<a href="${pageContext.request.contextPath}/html/verlauf.jsp">Buchungsverlauf ansehen</a>
	</div>
	<div class="aktion">
		<a href="${pageContext.request.contextPath}/html/Kontoauszuege.jsp">Kontoauszüge ansehen</a>
	</div>

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