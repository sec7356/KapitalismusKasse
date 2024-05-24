<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Karriere - Kapitalismuss-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>    

<nav id="navbar">
	<ul>
		<li>
			<div class="container">
				<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="image">
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
		<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp">Immobilien</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp"class="active">Karriere</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp">Banking-Login</a>
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
    <img src="${pageContext.request.contextPath}/img/Bild1.jpeg">
  </div>

  <div class="mySlides fade">
    <img src="${pageContext.request.contextPath}/img/Bild4.jpg">
  </div>
  

  <div class="dots">
  		<span class="dot"></span> 
  		<span class="dot"></span> 
  		<span class="dot"></span> 
 </div>

  <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  <a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>

<script src="${pageContext.request.contextPath}/JavaScript/navigation_extended.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/navigation.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/slideshow.js"></script>


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

        <a href="${pageContext.request.contextPath}/html/adminFormular.jsp" class="black-anchor">

        <button>Klicken zum Bewerben</button>

        </a>

        <h3>Passwort vergessen?</h3>

        <p>Hilfe finden Sie <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="black-anchor">hier</a>.</p>
    </aside>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>