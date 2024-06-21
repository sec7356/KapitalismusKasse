function confirmDelete() {
    if (confirm("Bist du sicher, dass du den Account löschen möchtest?")) {
        document.getElementById('deleteForm').submit();
    } else {
        // Abbrechen: Hier kannst du optional eine Aktion angeben oder einfach nichts tun
    }
}
