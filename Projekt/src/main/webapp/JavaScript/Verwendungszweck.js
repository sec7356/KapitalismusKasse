window.onload = function() {
	updateCharCount();
};

function updateCharCount() {
	var maxLength = 140;
	var currentLength = document.getElementById("verwendungszweck").value.length;
	var remaining = maxLength - currentLength;
	var charCountElement = document.getElementById("char-count");

	if (remaining >= 0) {
		charCountElement.textContent = "Sie können noch " + remaining
			+ " Zeichen eingeben.";
	}
}