<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="fehlermeldungAllgemein.jsp" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="../img/favicon.ico" />
    <title>KPT-Registrierung - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>


<nav id="navbar">
	<ul>
		<li>
			<div class="container">
				<img src="../img/logo.jpg" alt="Logo" class="image">
				<div class="company-name">
				<span>Kapitalismus-</span>
    			<span>Kasse</span>
    			</div>
    		</div>
		</li>
		<li><a href="../index.jsp">Privatkunden</a>
		</li>
		<li><a href="Firmenkunden.jsp">Firmenkunden</a>
		</li>
		<li><a href="Immobilien.jsp">Immobilien</a>
		</li>
		<li><a href="Karriere.jsp">Karriere</a>
		</li>
		<li><a href="Banking-Login.jsp"class="active">Banking-Login</a>
		</li>
	</ul>
</nav>
<br><br><br>

<div class="login_window">
    <div class="register-form">
        <div class="background-image"></div>
        <form method="post" action="../RegisterServlet">
            <div class="form-group">
                <h2>Willkommen im KPT-Kasse Online-Banking</h2>
                <p>Bitte geben Sie alle Daten ein.</p>
                <br>
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
                <label for="email">Email*</label>
                <input type="email" id="email" name="email" required maxlength="50">
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
            <div class="form-group">
				<span class="required-fields">*Pflichtfelder</span>
			</div>
            <div class="form-group">
                <button type="submit">Registrieren</button>
                <button type="reset">Zurücksetzen</button>
            </div>
            <div class="form-group">
                <p>Sie kommen nicht weiter?</p>
                <p>Hilfe finden Sie <a href="hilfe.jsp" class="black-anchor">hier</a>.</p>
            </div>
        </form>
    </div>
</div>


    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
