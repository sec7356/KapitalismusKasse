<!-- Validiert -->
<!-- Autor: Diane -->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/favicon.ico" />
    <title>Fehlermeldung - Kapitalismus-Kasse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style1.css">
</head>
<body>
    <header>
        <h1>Oops! Bei der Registrierung ist Etwas ist schief gelaufen.</h1>
    </header>

    <aside>
        <h2>Fehler</h2>
        <div>
            <p>Es sieht so aus, als hätten wir ein Problem bei der Registrierung. Bitte versuchen Sie es erneut.</p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/html/Banking-Login.jsp"">Zurück zur Startseite</a>
        </div>
    </aside>

    <article>
        <h3>Benötigen Sie Hilfe?</h3>
        <p>Erste Fehlerbehandlung finden Sie <a href="${pageContext.request.contextPath}/html/hilfe.jsp" class="black-anchor">hier</a>.</p>
        <p>Oder kontaktieren Sie uns <a href="${pageContext.request.contextPath}/html/kontakt.jsp" class="black-anchor">hier</a>.</p>
    </article>

    <footer>
        <p>&copy; 2024 Kapitalismus Kasse. Alle Rechte vorbehalten.</p>
    </footer>
</body>
</html>