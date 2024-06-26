<!-- Validiert -->
<!-- Autoren: Can, Diane -->
<!-- Style muss noch entfernt werden! -->

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
<title>Registrierung - Kapitalismus-Kasse</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/RegisterStyle.css">
<script src="${pageContext.request.contextPath}/JavaScript/captcha.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/navigation_extended2.js"></script>
<script src="${pageContext.request.contextPath}/JavaScript/navigation.js"></script>
<script src="https://www.google.com/recaptcha/api.js" defer></script>
<script src="${pageContext.request.contextPath}/JavaScript/registerValidation.js" defer></script>


<style>
    .email-container {
        position: relative;
        width: 100%;
    }

    #email {
        width: 100%;
        box-sizing: border-box; /* Include padding in width calculation */
        padding-right: 30px; /* Space for the status icon */
    }

    #emailStatus {
        position: absolute;
        right: 10px;
        top: 70%; /* Adjust as needed */
        transform: translateY(-50%);
    }

    #emailErrorMessage {
        position: absolute;
        top: 100%; /* Position directly below the email input */
        left: 0;
        width: 100%;
        text-align: left;
        color: #d9534f;
        font-size: 12px;
        display: none; /* Initially hide the error message */
    }
    
  .pin-input-container {
    position: relative;
}

.pin-input-container input {
    padding-right: 25px; /* Platz für das Feedback reservieren */
    box-sizing: border-box; /* Padding in Berechnung einbeziehen */
}

.pin-input-container::after {
    content: attr(data-feedback); /* Pseudo-Element für das visuelle Feedback */
    position: absolute;
    top: 50%;
    right: 5px; /* Abstand vom rechten Rand anpassen */
    transform: translateY(-50%);
    font-size: 18px; /* Optional: Größe des Symbols anpassen */
    color: #941100; /* Farbe für das Kreuz */
}

.pin-input-container.correct::after {
    content: '✔'; /* Inhalt für das Häkchen */
    color: #b89e14; /* Farbe für das Häkchen */
}

.pin-input-container.incorrect::after {
    content: '✘'; /* Inhalt für das Kreuz */
}    
</style>

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
            <li><a href="${pageContext.request.contextPath}/html/Banking-Login.jsp" class="active">Banking-Login</a></li>
        </ul>
    </nav>
    <br>
    <br>
    <br>
    
    <div class="login_window">
        <div class="register-form">
            <div class="background-image"></div>
            <form method="post" action="${pageContext.request.contextPath}/RegisterServlet">
                <div class="form-group">
                    <h2>Willkommen im KPT-Kasse <br><span>Online-Banking</span></h2>
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
                <br>
                <div class="form-group">
                   <div class="email-container">
                        <label for="email">Email*</label>
                        <input type="email" id="email" name="email" required maxlength="50">
                        <span id="emailStatus"></span>
                        <div class="form-group">
                            <span id="emailErrorMessage" class="required-fields" style="display: none;">Diese E-Mail ist nicht verfügbar. Wähle eine andere Adresse aus.</span>
                        </div>
                   </div>
                </div>
                <br>
                <div class="form-group flex-container">
                    <div class="flex-item">
                        <label for="pin1">PIN*</label>
                        <input type="password" id="pin1" name="pin1" placeholder="min. 3 Zahlen, max. 6 Zahlen" required maxlength="6">
                    </div>
                    <div class="flex-item">
                        <label for="pin2">PIN bestätigen*</label>
                        <div class="pin-input-container">
                            <input type="password" id="pin2" name="pin2" required maxlength="6" oninput="checkPINConfirmation()">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <span class="required-fields">*Pflichtfelder</span>
                </div>
                <div class="form-group">
                    <div class="g-recaptcha-container">
                        <div class="g-recaptcha" data-sitekey="6LezhuwpAAAAAIeLzgoFKHqHqLqkTqgEqpj33xBN"></div>
                    </div>
                </div>
                <div class="form-group buttons">
                    <button id="registerButton" type="submit">Registrieren</button>
                    <button type="reset">Zurücksetzen</button>
                </div>
                <div class="form-group">
                    <p><b>Sie kommen nicht weiter?</b></p>
                    <p>Hilfe finden Sie <a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="black-anchor">hier</a>.</p>
                    <p>Oder kontaktieren Sie uns <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="black-anchor">hier</a>.</p>
                </div>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>
