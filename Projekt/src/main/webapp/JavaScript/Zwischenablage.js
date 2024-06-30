//Autor: @Diane
"use strict";

function copyToClipboardAndDisplayText(text) {
    navigator.clipboard.writeText(text).then(function() {
        alert('IBAN wurde in die Zwischenablage kopiert!');
    }).catch(function(error) {
        console.error('Fehler beim Kopieren in die Zwischenablage:', error);
    });
}

