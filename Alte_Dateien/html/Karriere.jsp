<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="fehlermeldungAllgemein.jsp" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="../img/favicon.ico" />
    <title>Karriere - Kapitalismuss-Kasse</title>
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
		<li><a href="Immobilien.jsp">Immobilien</a>
		</li>
		<li><a href="Karriere.jsp"class="active">Karriere</a>
		</li>
		<li><a href="Banking-Login.jsp">Banking-Login</a>
		</li>
	</ul>
</nav>

<!-- Slide-Show-Inhalt -->

<div class="slideshow-container">
  <div class="mySlides fade">
  	<div class="text">Auf der Suche<br> nach Reichtum?</div>
  	<div class="text_info">Denn von jedem neuen Kunden  <br> profitieren unseren Mitglieder - <br>und auch wir!</div>
    <img src="../img/Bild5.jpg">
  </div>

  <div class="mySlides fade">
    <img src="../img/Bild1.jpeg">
  </div>

  <div class="mySlides fade">
    <img src="../img/Bild4.jpg">
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


<br><br><br>

    <article>
        <h2>Ihre Vorteile bei einer Karriere bei uns:</h2>
        <ul>
        <li>Einblicke auf alle Kontostände</li>
        <li>Anpassung des eigenen Kontostands</li>
        <li>Kostenlose Arbeitsbekleidung mit Kapitalismus-Kasse-Emblem</li>
        <li>Lebenslange Arbeitsgarantie</li>
        </ul>
        
        <h2>Was wir von Ihnen erwarten:</h2>
        <ul>
        <li>Lebenslange Arbeitspflicht</li>
        <li>Keine Kentnisse oder Arbeitserfahrung notwendig</li>
        <li>Gefühlslosigkeit</li>
        <li>Fähigkeit realitätsnahe Lügen zu erfinden</li>
        </ul>
    </article>

    <aside>
        <h3>Bewerben Sie sich jetzt!</h3>

        <a href="adminFormular.jsp" class="black-anchor">

        <button>Klicken zum Bewerben</button>

        </a>

        <h3>Bereits Mitglied?</h3>

        <p>Klicken sie zum Einloggen <a href="Banking-Login.jsp" class="black-anchor">hier</a>.</p>

        <h3>Passwort vergessen?</h3>

        <p>Hilfe finden Sie <a href="passwortReset.jsp" class="black-anchor">hier</a>.</p>
    </aside>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
