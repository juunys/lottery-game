document.addEventListener("DOMContentLoaded", () => {
	const overlay = document.getElementById("loading-overlay");

	// Remove o overlay quando a página termina de carregar
	setTimeout(() => {
		overlay.classList.add("hidden");
}, 300); // Tempo para dar um efeito suave
});

window.addEventListener("beforeunload", () => {
	// Mostra o overlay ao navegar para outra página
	const overlay = document.getElementById("loading-overlay");
	overlay.classList.remove("hidden");
});