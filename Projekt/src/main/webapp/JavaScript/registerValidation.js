/* register.js */

console.log("Skript erfolgreich geladen.");

document.addEventListener("DOMContentLoaded", init);

function init() {
    console.log("DOM-Inhalt geladen.");
    
    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('input', handleEmailInput);
    } else {
        console.error("E-Mail-Eingabefeld nicht gefunden.");
    }
}

function handleEmailInput() {
    const email = document.getElementById('email').value.trim();
    if (email !== '') {
        checkEmailAvailability(email);
    } else {
        clearEmailStatus();
        disableRegisterButton();
    }
}

function checkEmailAvailability(email) {
    console.log("Überprüfe Verfügbarkeit der E-Mail für: " + email);
    
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.responseType = "json";
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
            handleEmailResponse(xmlhttp.response);
        }
    };
    
    // Hier direkt den Pfad zum Servlet angeben, z.B. '/CheckEmailAvailability'
    xmlhttp.open("POST", '../CheckEmailAvailability', true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlhttp.send("email=" + encodeURIComponent(email));
}

function handleEmailResponse(response) {
    console.log("Behandle E-Mail-Antwort:", response);
    
    const emailStatus = document.getElementById('emailStatus');
    const emailErrorMessage = document.getElementById('emailErrorMessage');
    const registerButton = document.getElementById('registerButton');

    if (response && response.available === false) {
        emailStatus.textContent = '✘';
        emailStatus.style.color = '#941100';
        emailErrorMessage.textContent = 'Diese E-Mail ist nicht verfügbar. Wähle eine andere Adresse aus.';
        emailErrorMessage.style.display = 'block';
        disableRegisterButton();
    } else if (response && response.available === true) {
        emailStatus.textContent = '✔';
        emailStatus.style.color = '#b89e14';
        emailErrorMessage.textContent = '';
        emailErrorMessage.style.display = 'none';
        enableRegisterButton();
    } else {
        clearEmailStatus();
        disableRegisterButton();
    }
}

function clearEmailStatus() {
    const emailStatus = document.getElementById('emailStatus');
    if (emailStatus) {
        emailStatus.textContent = '';
    } else {
        console.error("E-Mail-Status-Element nicht gefunden.");
    }
}

function disableRegisterButton() {
    const registerButton = document.getElementById('registerButton');
    if (registerButton) {
        registerButton.disabled = true;
    } else {
        console.error("Registrierungsbutton nicht gefunden.");
    }
}

function enableRegisterButton() {
    const registerButton = document.getElementById('registerButton');
    if (registerButton) {
        registerButton.disabled = false;
    } else {
        console.error("Registrierungsbutton nicht gefunden.");
    }
}

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
