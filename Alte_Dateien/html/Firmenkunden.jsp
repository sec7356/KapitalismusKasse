<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="fehlermeldungAllgemein.jsp" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="../img/favicon.ico" />
    <title>Firmenkunden - Kapitalismuss-Kasse</title>
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
		<li><a href="Firmenkunden.jsp"class="active">Firmenkunden</a>
		</li>
		<li><a href="Immobilien.jsp">Immobilien</a>
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
  	<div class="text">Deine Firma<br> Unsere Firma!</div>
  	<div class="text_info">Denn als Gemeinschaftsbank <br> teilen wir alles mit unseren Mitgliedern. <br>Bei uns ist Ihre Firma sicher!</div>
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

<br><br><br><br>

    <aside>
        <h2>Ihre Vorteile bei uns als Firmenkunde:</h2>
        <ul>
        <li>Kostenlose Internationale Überweisungen jeglicher Art</li>
        <li>Rund um die Uhr Support-Möglichkeiten mit unseren Betreuern</li>
        <li>Überweisungen ohne die Überwachung Ihrer Firma</li>
        <li>High-Level Support für Ihre Geldwäsche</li>
        </ul>
    </aside>

    <article>
        <h3>Registrieren Sie sich jetzt als Firmenkunde!</h3>
        <a href="Registrierung.jsp" class="black-anchor">
        <button>Klicken zum Registrieren</button>
        </a>
        <h3>Bereits registriert?</h3>
        <p>Klicken sie zum Einloggen <a href="Banking-Login.jsp" class="black-anchor">hier</a>.</p>
        <h3>Passwort vergessen?</h3>
        <p>Hilfe finden Sie <a href="passwortReset.jsp" class="black-anchor">hier</a>.</p>
    </article>
    
    <!-- Hier vielleicht FAQ/Q&A einfügen -->
    

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
