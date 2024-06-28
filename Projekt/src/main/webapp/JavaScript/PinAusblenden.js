//Autor: @Can

'use strict'

document.addEventListener('DOMContentLoaded', () => {
    const pinCells = document.querySelectorAll('.pin-cell');

    pinCells.forEach(cell => {
        const pinContent = cell.querySelector('.pin-content');

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
