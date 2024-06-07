"use strict";

var timerId;
var logoutUrl = "/KapitalismusKasse/LogoutServlet";

function startTimer() {
    var timer = document.getElementById('timer');
    if (!timer) {
        console.error("Timer Element nicht gefunden!");
        return;
    }
    var timeArray = timer.textContent.split(":");
    var minutes = parseInt(timeArray[0], 10);
    var seconds = parseInt(timeArray[1], 10);

    if (isNaN(minutes) || isNaN(seconds)) {
        console.error("Ungültiges Timer-Format!");
        return;
    }

    if (minutes === 0 && seconds === 0) {
        console.log("Logout ausgelöst!");
        alert("Sie wurden aus Sicherheitsgründen abgemeldet!");
        window.location.href = logoutUrl;
        return;
    }

    seconds--;
    if (seconds < 0) {
        minutes--;
        seconds = 59;
    }

    timer.textContent = minutes + ":" + seconds.toString().padStart(2, "0");

    localStorage.setItem('remainingTime', timer.textContent);

    timerId = setTimeout(startTimer, 1000);
}

function resetTimer() {
    clearTimeout(timerId);

    document.getElementById('timer').textContent = "5:00";

    localStorage.setItem('remainingTime', "5:00");

    startTimer();
}

function restoreTimer() {
    var savedTime = localStorage.getItem('remainingTime');
    if (savedTime) {
        document.getElementById('timer').textContent = savedTime;
    } else {
        document.getElementById('timer').textContent = "5:00";
    }
}

document.addEventListener("mousemove", resetTimer);
document.addEventListener("keydown", resetTimer);
document.addEventListener("click", resetTimer);

document.addEventListener("DOMContentLoaded", function() {
    restoreTimer();
    startTimer();
});

localStorage.removeItem('remainingTime');

