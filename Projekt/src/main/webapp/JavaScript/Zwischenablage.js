function copyToClipboardAndDisplayText(text) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    var alertBox = alert('IBAN in Zwischenablage kopiert');

    // Die Alert-Box nach drei Sekunden ausblenden
    setTimeout(function() {
        alertBox.close();
    }, 3000);
}
