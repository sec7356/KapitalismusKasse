<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Registrierung - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/RegisterStyle.css">
    <script src="${pageContext.request.contextPath}/JavaScript/captcha.js"></script> <!-- Überprüfen (Infos & required) -->
    <script src="https://www.google.com/recaptcha/api.js" async defer></script> <!-- Google reCaptcha -->
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
		<li><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp" class="active">Banking-Login</a>
		</li>
	</ul>
</nav>
<br><br><br>
<main>
<div class="login_window">
    <div class="register-form">
        <div class="background-image"></div>
        <form method="post" action="${pageContext.request.contextPath}/RegisterServlet">
        <div class="flex-item">
            <div class="form-group">
                <h2>Willkommen im KPT-Kasse Online-Banking</h2>
                <p>Bitte geben Sie alle Daten ein.</p>
                <br>
            </div>
            </div>
            <div class="form-group flex-container">
                <div class="flex-item">
                    <label for="vorname">Ihr Vorname*</label>
                    <input type="text" id="vorname" name="vorname" required maxlength="30">
                </div>
                <div class="flex-item">
                    <label for="nachname">Ihr Nachname*</label>
                    <input type="text" id="nachname" name="nachname" required maxlength="30">
                </div>
            </div>
            <div class="form-group">
            <div class="flex-item">
                <label for="email">Email*</label>
                <input type="email" id="email" name="email" required maxlength="50">
            </div>
            </div>
            <div class="form-group flex-container">
                <div class="flex-item">
                    <label for="pin1">PIN*</label>
                    <input type="password" id="pin1" name="pin1" placeholder="max. 6 Ziffern" required maxlength="6">
                </div>
                <div class="flex-item">
                    <label for="pin2">PIN bestätigen*</label>
                    <input type="password" id="pin2" name="pin2" required maxlength="6">
                </div>
            </div>
            
            <div class="flex-item">
            <div class="g-recaptcha" data-sitekey="6LezhuwpAAAAAIeLzgoFKHqHqLqkTqgEqpj33xBN"></div>
            
            
            <div class="form-group">
				<span class="required-fields">*Pflichtfelder</span>
			</div>
            <div class="form-group">
                <button type="submit">Registrieren</button>
                <button type="reset">Zurücksetzen</button>
            </div>
            <div class="form-group">
                <p><b>Sie kommen nicht weiter?</b></p>
                <p>Hilfe finden Sie <a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="black-anchor">hier</a>.</p>
                <p>Oder kontaktieren Sie uns <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="black-anchor">hier</a>.</p>
            </div>
            </div>
        </form>
    </div>
</div>

</main>
    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>