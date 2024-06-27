<!-- Validiert -->
<!-- Autor: Diane -->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
<title>Login - Kapitalismus-Kasse</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginStyle.css">
<script src="${pageContext.request.contextPath}/JavaScript/popupLöschen.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/logout-message.js"></script> 


</head>
<body>
	<nav id="navbar">
		<ul>
			<li>
				<div class="container">
					<img src="${pageContext.request.contextPath}/img/logo.jpg" alt="Logo" class="image">
					<div class="company-name">Kapitalismus<br> Kasse</div>
				</div>
			</li>
			<li><a href="${pageContext.request.contextPath}/index.jsp">Privatkunden</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Firmenkunden.jsp">Firmenkunden</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp">Immobilien</a></li>
			<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp">Karriere</a></li>
			<li class="right2"><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp" class="active">Banking-Login</a></li>
		</ul>
	</nav>
	
	<br>
	
	<div class="login_window">
		<div class="login-form">
			<form action="${pageContext.request.contextPath}/LoginServlet"
				method="post">
				<div class="form-group">
					<h2>Willkommen im KPT-Kasse Online-Banking</h2>
					<p>Bitte loggen Sie sich ein.</p>
					<br>
					<!-- Prüfe, ob das errorMessage Attribut gesetzt und nicht null ist -->
					<c:if test="${not empty requestScope.errorMessage}">
					    <div id="logout-message">${requestScope.errorMessage}</div>
					</c:if>
					<!-- Prüfe, ob das logoutMessage Session-Attribut existiert und nicht leer ist -->
					<c:if test="${not empty sessionScope.logoutMessage}">
    					<div id="logout-message">${sessionScope.logoutMessage}</div>
   						<!-- Lösche das logoutMessage Session-Attribut -->
    					<c:remove var="logoutMessage" scope="session"/>
					</c:if>
					
					<label for="email">Direct-Banking-Email*</label> <input type="email" id="email" name="email" required maxlength="50">
				</div>
				<div class="form-group">
					<label for="pin">PIN (Direct-Banking-PIN)*</label> <input type="password" id="pin" name="pin" required maxlength="6">
				</div>
				<div class="form-group">
					<span class="required-fields">*Pflichtfelder</span>
					<button type="submit">Anmelden</button>
				</div>
				<div class="form-group">
					<p><b>Probleme beim Anmelden?</b></p>
					<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/hilfe.jsp'">Klicken für Hilfe</button>
					
					<p><b>Neu hier?</b></p>
					<button type="button" class="buttonStyle" onclick="location.href='${pageContext.request.contextPath}/html/Registrierung.jsp'">Klicken zum Registrieren</button>
				</div>
			</form>
		</div>
	</div>
	
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>
</body>
</html>
