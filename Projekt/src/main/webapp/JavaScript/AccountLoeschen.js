function confirmDelete() {
    if (confirm("Sind Sie sich sicher, dass Sie den Account löschen möchten?\nSie landen danach wieder auf der Admin-Konsole")) {
        document.getElementById('deleteForm').submit();
    } else {
        // Abbrechen: Hier kannst du optional eine Aktion angeben oder einfach nichts tun
    }
}
