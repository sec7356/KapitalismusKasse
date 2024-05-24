<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="fehlermeldungAllgemein.jsp" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/x-icon" href="../img/favicon.ico" />
    <title>Immobilien - Kapitalismuss-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
		<li><a href="../index.jsp">Privatkunden</a>
		</li>
		<li><a href="Firmenkunden.jsp">Firmenkunden</a>
		</li>
		<li><a href="Immobilien.jsp"class="active">Immobilien</a>
		</li>
		<li><a href="Karriere.jsp">Karriere</a>
		</li>
		<li><a href="Banking-Login.jsp">Banking-Login</a>
		</li>
	</ul>
</nav>


<!-- Slide-Show-Inhalt -->

<div class="slideshow-container">
  <div class="mySlides fade">
  	<div class="text">x<br> x</div>
  	<div class="text_info">x <br> x <br>x</div>
    <img src="../img/Bild4.jpg">
  </div>

  <div class="mySlides fade">
    <img src="../img/Bild2.jpeg">
  </div>

  <div class="mySlides fade">
    <img src="../img/Bild3.jpg">
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
        <ul>
        <li>x</li>
        <li>x</li>
        <li>x</li>
        </ul>
    </aside>

<!-- Hier Link und Beschriftung zur Seite für Immobilien/Registrieren einfügen -->
    <article>
        <h3>Jetzt x</h3>
        <a href="x" class="black-anchor">
        <button>Klicken zum x</button>
        </a>
        <h3>Bereits Mitglied?</h3>
        <p>Klicken sie zum Einloggen <a href="Banking-Login.html" class="black-anchor">hier</a>.</p>
        <h3>Passwort vergessen?</h3>
        <p>Hilfe finden Sie <a href="passwortReset.html" class="black-anchor">hier</a>.</p>
    </article>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
