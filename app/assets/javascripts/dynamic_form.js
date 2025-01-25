document.addEventListener("DOMContentLoaded", () => {
  const gameTypeSelect = document.querySelector("#game_type_id");
  const numbersPerGameInput = document.querySelector("#numbers_per_game");

  if (gameTypeSelect && numbersPerGameInput) {
    gameTypeSelect.addEventListener("change", (event) => {
      const selectedGame = event.target.options[event.target.selectedIndex];
      const maxNumber = selectedGame.getAttribute("data-max-number");
      numbersPerGameInput.setAttribute("max", maxNumber);
    });
  }
});
