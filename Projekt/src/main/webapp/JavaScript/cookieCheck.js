//Autor: @Selim

"use strict";

// Überprüfung der Cookies nach dem Laden der Seite
        window.onload = checkCookiesEnabled;
        document.getElementById("reloadButton").addEventListener("click", location.reload());

function checkCookiesEnabled() {
            // Versuch einen Test-Cookie zu setzen
            document.cookie = "testcookie=1";
            const cookiesEnabled = document.cookie.indexOf("testcookie") !== -1;

            if (cookiesEnabled) {
                // Cookie löschen
                document.cookie = "testcookie=1; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                if (!getCookie('successShown')) {
                    showSuccessPopup();
                    setCookie('successShown', '1', 1); // Cookie setzen für einen Tag
                }
            } else {
                showAlert();
            }
        }

        function showSuccessPopup() {
            var successPopup = document.getElementById("cookieSuccess");
            successPopup.style.display = "block";
            setTimeout(() => {
                successPopup.style.display = "none";
            }, 2000);
        }

        function showAlert() {
            alert("Bitte aktivieren Sie Ihre Cookies um fortzufahren");
            // Seite neu laden nach dem Schließen des Alerts
            location.reload();
        }

        function setCookie(name, value, days) {
            let expires = "";
            if (days) {
                const date = new Date();
                date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                expires = "; expires=" + date.toUTCString();
            }
            document.cookie = name + "=" + (value || "") + expires + "; path=/";
        }

        function getCookie(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (let i = 0; i < ca.length; i++) {
                let c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }

        