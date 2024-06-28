//Autor: @Can

document.getElementById("resetZeichen").addEventListener("onclick", resetForm());

window.onload = function() {
    updateCharCount();
    var form = document.getElementById('myForm');
    form.addEventListener('reset', function() {
        setTimeout(updateCharCount, 0); // Timeout, um sicherzustellen, dass das Zurücksetzen abgeschlossen ist
    });
    var inputField = document.getElementById("verwendungszweck");
    inputField.addEventListener("input", updateCharCount);
};

function updateCharCount() {
    var maxLength = 140;
    var currentLength = document.getElementById("verwendungszweck").value.length;
    var remaining = maxLength - currentLength;
    var charCountElement = document.getElementById("char-count");

    if (remaining >= 0) {
        charCountElement.textContent = "Sie können noch " + remaining + " Zeichen eingeben.";
    } else {
        charCountElement.textContent = "Maximale Zeichenanzahl überschritten!";
    }
}

function resetForm() {
    // Zurücksetzen des Eingabefelds
    document.getElementById("verwendungszweck").value = "";
    // Manuelle Aktualisierung des Zeichenzählers
    updateCharCount();
}
