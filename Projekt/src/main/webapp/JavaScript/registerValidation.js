document.addEventListener("DOMContentLoaded", init);

function init() {
    const emailInput = document.getElementById('email');
    emailInput.addEventListener('input', handleEmailInput);
}

function handleEmailInput() {
    const email = document.getElementById('email').value.trim();
    if (email !== '') {
        checkEmailAvailability(email);
    } else {
        clearEmailStatus();
        disableRegisterButton(); // Button deaktivieren, wenn das E-Mail-Feld leer ist
    }
}

function checkEmailAvailability(email) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.responseType = "json";
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            handleEmailResponse(xmlhttp.response);
        }
    };
    const contextPath = document.getElementById('contextPath').value;
    xmlhttp.open("POST", contextPath + "/CheckEmailAvailability", true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlhttp.send("email=" + encodeURIComponent(email));
}

function handleEmailResponse(response) {
    const emailStatus = document.getElementById('emailStatus');
    const emailErrorMessage = document.getElementById('emailErrorMessage');
    const registerButton = document.getElementById('registerButton');

    if (response && response.available === false) {
        emailStatus.textContent = '✘'; // Kreuz
        emailStatus.style.color = '#941100';
        emailErrorMessage.textContent = 'Diese E-Mail ist nicht verfügbar. Wähle eine andere Adresse aus.';
        emailErrorMessage.style.display = 'block'; // Fehlermeldung anzeigen
        disableRegisterButton(); // Button deaktivieren
    } else if (response && response.available === true) {
        emailStatus.textContent = '✔'; // Häkchen
        emailStatus.style.color = '#b89e14';
        emailErrorMessage.textContent = ''; // Fehlermeldung zurücksetzen
        emailErrorMessage.style.display = 'none'; // Fehlermeldung verstecken
        enableRegisterButton(); // Button aktivieren
    } else {
        clearEmailStatus();
        disableRegisterButton(); // Button deaktivieren, falls keine gültige Antwort
    }
}

function clearEmailStatus() {
    const emailStatus = document.getElementById('emailStatus');
    emailStatus.textContent = '';
}

function disableRegisterButton() {
    const registerButton = document.getElementById('registerButton');
    registerButton.disabled = true;
}

function enableRegisterButton() {
    const registerButton = document.getElementById('registerButton');
    registerButton.disabled = false;
}

// PIN Überprüfung
function checkPINConfirmation() {
    const pin1 = document.getElementById('pin1').value;
    const pin2 = document.getElementById('pin2').value;
    const pinInputContainer = document.querySelector('.pin-input-container');

    if (pin1 === pin2 && pin2 !== '') {
        pinInputContainer.classList.remove('incorrect');
        pinInputContainer.classList.add('correct');
        pinInputContainer.setAttribute('data-feedback', '✔');
    } else {
        pinInputContainer.classList.remove('correct');
        pinInputContainer.classList.add('incorrect');
        pinInputContainer.setAttribute('data-feedback', '✘');
    }
}
