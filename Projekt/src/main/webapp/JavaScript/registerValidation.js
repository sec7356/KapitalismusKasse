//Autor: Diane 
"use strict";

document.addEventListener("DOMContentLoaded", init);

function init() {    
    var emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('input', handleEmailInput);
    } else {
    }
}

function handleEmailInput() {
    var email = document.getElementById('email').value.trim();
    if (email !== '') {
        checkEmailAvailability(email);
    } else {
        clearEmailStatus();
        disableRegisterButton();
    }
}

function checkEmailAvailability(email) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.responseType = "json";

    xmlhttp.addEventListener("load", handleEmailResponse);
    
    xmlhttp.open("POST", '../CheckEmailAvailability', true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlhttp.send("email=" + encodeURIComponent(email));
}

function handleEmailResponse( ) {
    var response = this.response;
    var emailStatus = document.getElementById('emailStatus');
    var emailErrorMessage = document.getElementById('emailErrorMessage');

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
    var emailStatus = document.getElementById('emailStatus');
    if (emailStatus) {
        emailStatus.textContent = '';
    } else {
    }
}

function disableRegisterButton() {
    var registerButton = document.getElementById('registerButton');
    if (registerButton) {
        registerButton.disabled = true;
    } else {
    }
}

function enableRegisterButton() {
    var registerButton = document.getElementById('registerButton');
    if (registerButton) {
        registerButton.disabled = false;
    } else {
    }
}

function checkPINConfirmation() {
    var pin1 = document.getElementById('pin1').value;
    var pin2 = document.getElementById('pin2').value;
    var pinInputContainer = document.querySelector('.pin-input-container');

    if (pin1 === pin2 && pin2 !== '') {
        pinInputContainer.classList.remove('incorrect');
        pinInputContainer.classList.add('correct');
        pinInputContainer.setAttribute('data-feedback', '✔');
    } else {
        pinInputContainer.classList.remove('correct');
        pinInputContainer.classList.add('incorrect');
        pinInputContainer.setAttribute('data-feedback', '✘');
    }
}