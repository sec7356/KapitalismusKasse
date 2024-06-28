//Autor: @Can

"use strict";

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('nach').addEventListener('input', function() {
        var nachInput = this;
        var nachIcon = document.getElementById('nach-icon');
        
        if (nachInput.validity.valid) {
            nachIcon.textContent = '✔'; // Unicode für grünes Häkchen
            nachIcon.classList.remove('error');
            nachIcon.classList.add('success');
        } else {
            nachIcon.textContent = '✘'; // Unicode für rotes Kreuz
            nachIcon.classList.remove('success');
            nachIcon.classList.add('error');
        }
    });

    document.getElementById('summe').addEventListener('input', function() {
        var summeInput = this;
        var summeIcon = document.getElementById('summe-icon');
        
        if (summeInput.validity.valid) {
            summeIcon.textContent = '✔'; // Unicode für grünes Häkchen
            summeIcon.classList.remove('error');
            summeIcon.classList.add('success');
        } else {
            summeIcon.textContent = '✘'; // Unicode für rotes Kreuz
            summeIcon.classList.remove('success');
            summeIcon.classList.add('error');
        }
    });
});
