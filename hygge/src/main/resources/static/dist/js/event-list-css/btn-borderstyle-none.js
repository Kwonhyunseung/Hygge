window.addEventListener('load', function() {
	const btns = document.querySelectorAll('.search-container .btn');
	btns.forEach(btn => {
		btn.addEventListener("mouseup", () => {
			btn.style.borderStyle = "none";
		});
		btn.addEventListener("mousedown", () => {
			btn.style.borderStyle = "none";
		});
	});
});