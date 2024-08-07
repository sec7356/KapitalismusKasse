<!-- Autor: Diane -->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico">
<title>Login - Kapitalismus-Kasse</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loginStyle.css">
<script src="${pageContext.request.contextPath}/JavaScript/popupLöschen.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/logout-message.js"></script> 
<script src="${pageContext.request.contextPath}/JavaScript/cookieCheck.js"></script>
</head>
<body>
	<div id="cookieSuccess">✅ Cookie-Zugriff erfolgreich!</div>
	    <div id="cookieWarning">Bitte aktivieren Sie Ihre Cookies um fortzufahren!<br>
	        <button id="reloadButton">Neu laden</button>
   		</div>
   		
<noscript>
<div class="noscript-message-container">
            <div class="noscript-message">
                JavaScript ist deaktiviert. Bitte aktivieren Sie JavaScript, um diese Webseite vollständig nutzen zu können.
            </div>
        </div>
</noscript>

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
        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <div class="form-group">
                <h2>Willkommen im KPT-Kasse Online-Banking</h2>
                <p>Bitte loggen Sie sich ein.</p>
                <br>
                <c:if test="${not empty sessionScope.errorMessage}">                
                    <div id="logout-message">${sessionScope.errorMessage}</div>
                    <c:remove var="errorMessage" scope="session"/>
                </c:if>
                <c:if test="${not empty sessionScope.logoutMessage}">
                    <div id="logout-message">${sessionScope.logoutMessage}</div>
                    <!-- Lösche das logoutMessage Session-Attribut -->
                    <c:remove var="logoutMessage" scope="session"/>
                </c:if>
                
                <label for="email">Direct-Banking-Email*</label>
                <input type="email" id="email" name="email" required maxlength="50">
            </div>
            <div class="form-group">
                <label for="pin">PIN (Direct-Banking-PIN)*</label>
                <input type="password" id="pin" name="pin" required maxlength="6">
            </div>
            <div class="form-group">
                <span class="required-fields">*Pflichtfelder</span>
                <button type="submit">Anmelden</button>
            </div>
            <div class="form-group">
                <p><b>Probleme beim Anmelden?</b></p>
    			<a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="buttonStyle">Klicken für Hilfe</a>
                                
                <p><b>Neu hier?</b></p>
          		<a href="${pageContext.request.contextPath}/html/Registrierung.jsp" class="buttonStyle">Klicken zum Registrieren</a>
                
            </div>
        </form>
    </div>
</div>

<!-- Versteckte Felder für Nachrichten -->
<input type="hidden" id="showMessage" value="${requestScope.showMessage != null ? requestScope.showMessage : 'false'}">
<input type="hidden" id="successMessage" value="${requestScope.successMessage != null ? requestScope.successMessage : ''}">

<!-- Hier wird die Popup-Nachricht angezeigt -->
<div id="popup" class="popup" style="display:none;">
    <p id="popupMessage" class="popup-message"></p>
    <button id="bestaetigen" class="popup-button">Verstanden!</button>
</div>
	
	<footer>
		<p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
		<p>Soweit auf dieser Internetseite von der Kapitalismus Kasse die Rede ist, bezieht sich dies auf die Angebote der Kapitalismus 
		Kasse AG, Kapitalismusstr. 1, 60329 Frankfurt am Main.</p>
	</footer>
</body>
</html>
