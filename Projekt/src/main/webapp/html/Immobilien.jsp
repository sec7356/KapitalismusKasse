<!-- Autor:  -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
    <title>Immobilien - Kapitalismuss-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styleExtern.css">
</head>
<body>
  
<nav id="navbar">
	<ul>
		<li>
			<div class="container">
				<img src="../img/logo.jpg" alt="Logo" class="image">
				<div class="company-name">
					Kapitalismus-<br>
					Kasse
    			</div>
    		</div>
		</li>
		<li><a href="${pageContext.request.contextPath}/index.jsp">Privatkunden</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Firmenkunden.jsp">Firmenkunden</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp" class="active">Immobilien</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp">Karriere</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Banking-Login</a>
		</li>
	</ul>
</nav>


<!-- Slide-Show-Inhalt -->

<div class="slideshow-container">
  <div class="mySlides fade">
  	<div class="text">x<br> x</div>
  	<div class="text_info">x <br> x <br>x</div>
    <img src="${pageContext.request.contextPath}/img/Bild4.jpg" alt="Werbung">
  </div>

  <div class="mySlides fade">
    <img src="${pageContext.request.contextPath}/img/Bild2.jpeg" alt="Werbung">
  </div>

  <div class="mySlides fade">
    <img src="${pageContext.request.contextPath}/img/Bild3.jpg" alt="Werbung">
  </div>
  

  <div class="dots">
  		<span class="dot"></span> 
  		<span class="dot"></span> 
  		<span class="dot"></span> 
 </div>

  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>

<script src="../JavaScript/navigation_extended.js"></script>
<script src="../JavaScript/navigation.js"></script>
<script src="../JavaScript/slideshow.js"></script>

<!-- Vorteile oder Informationen als Liste -->
<br><br><br><br>

<!-- Vorteile oder Informationen als Liste -->

    <aside>
        <h2>Ihre Vorteile bei uns für Ihre Immobilien:</h2>
        <ul  class="reset-ul">
        <li>x</li>
        <li>x</li>
        <li>x</li>
        </ul>
    </aside>

<!-- Hier Link und Beschriftung zur Seite für Immobilien/Registrieren einfügen -->
    <article>
        <h3>Registrieren Sie sich jetzt!</h3>
    	<button type="button" onclick="location.href='${pageContext.request.contextPath}/html/Registrierung.jsp'">Klicken zum Registrieren</button>        
        <h3>Passwort vergessen?</h3>
        <p>Hilfe finden Sie <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="black-anchor">hier</a>.</p>
    </article>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
