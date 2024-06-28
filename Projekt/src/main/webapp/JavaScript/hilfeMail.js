//Autor: @Selim

"use strict";

function loadEvents() {
            var mailString;
            function updateMailString() {
                mailString = '?subject=' + encodeURIComponent($('#betreff').val())
                    + '&body=' + encodeURIComponent($('#beschreibung').val());
                $('#mail-link').attr('href', 'mailto:kpt-kasse@navalcadets.com' + mailString);
            }
            $( "#betreff" ).focusout(function() { updateMailString(); });
            $( "#beschreibung" ).focusout(function() { updateMailString(); });
            updateMailString();
        }

        $(document).ready(function() {
            loadEvents();
        });

        function sendMail(event) {
            event.preventDefault();
            var subject = encodeURIComponent($('#betreff').val());
            var body = encodeURIComponent($('#beschreibung').val());
            var mailToLink = 'mailto:kpt-kasse@navalcadets.com?subject=' + subject + '&body=' + body;
            window.location.href = mailToLink;
            setTimeout(function() {
                refreshPage();
            }, 1000);
        }
        
        function refreshPage() {
        	location.reload();
        }