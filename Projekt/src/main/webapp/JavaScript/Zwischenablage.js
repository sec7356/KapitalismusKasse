//Autor: @Diane

"use strict";

function copyToClipboardAndDisplayText(text) {
    navigator.clipboard.writeText(text).then(function() {
        alert('IBAN wurde in die Zwischenablage kopiert!');
    }).catch(function(error) {
        console.error('Fehler beim Kopieren in die Zwischenablage:', error);
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // Add event listeners for all buttons with the class 'copy-button'
    document.querySelectorAll('.copy-button').forEach(function(button) {
        button.addEventListener('click', function() {
            const textToCopy = button.getAttribute('data-text');
            copyToClipboardAndDisplayText(textToCopy);
        });
    });
});
