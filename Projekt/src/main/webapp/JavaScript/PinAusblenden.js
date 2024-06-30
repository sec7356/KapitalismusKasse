//Autor: @Can

"use strict";

document.addEventListener('DOMContentLoaded', () => {
    var pinCells = document.querySelectorAll('.pin-cell');

    pinCells.forEach(cell => {
        var pinContent = cell.querySelector('.pin-content');

        if (pinContent) { // Überprüfen Sie, ob pinContent vorhanden ist
            cell.addEventListener('mouseover', () => {
                pinContent.style.display = 'block'; // Ändern Sie display auf 'block'
            });

            cell.addEventListener('mouseout', () => {
                pinContent.style.display = 'none';
            });
        }
    });
});
