//Autor: @Diane

function copyToClipboardAndDisplayText(text) {
    navigator.clipboard.writeText(text).then(function() {
        alert('IBAN wurde in die Zwischenablage kopiert!');
    }).catch(function(err) {
        console.error('Fehler beim Kopieren in die Zwischenablage: ', err);
    });
}
