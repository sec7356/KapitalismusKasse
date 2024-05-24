<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>KPT-Login - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
		<li><a href="${pageContext.request.contextPath}/index.jsp">Privatkunden</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Firmenkunden.jsp">Firmenkunden</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Immobilien.jsp">Immobilien</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Karriere.jsp">Karriere</a>
		</li>
		<li><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp"class="active">Banking-Login</a>
		</li>
	</ul>
</nav>
<br>

 <div class="login_window">
        <div class="login-form">
        <div class="background-image"></div>
            
            <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
                <div class="form-group">
                 	<h2>Willkommen im KPT-Kasse Online-Banking</h2>
                 	<p>Bitte loggen Sie sich ein.</p>
                 	<br>
                    <label for="email">Direct-Banking-Email*</label>
                    <input type="text" id="username" name="username" required maxlength="50">
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
                	<p><b>Passwort vergessen?</b></p>
                	<p>Hilfe finden Sie Sie <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="black-anchor">hier</a>.</p>
                
                	<p><b>Neu hier?</b></p>
                	<p>Registrieren Sie sich <a href="${pageContext.request.contextPath}/html/Registrierung.jsp" class="black-anchor">hier</a>.</p>
                
                
                </div>
                
            </form>
        </div>
    </div>


    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>