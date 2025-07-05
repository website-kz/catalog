const clickSound = new Audio("notify.mp3"); 

link.addEventListener("click", () => {
  if (Notification.permission === "granted") {
    new Notification("🎁 Кодовое слово: FReedoM500", {
      body: "Скидка 500₽ активна. Не делитесь этим кодом.",
      icon: "icons/img-1187.jpeg"
    });
  }
  clickSound.play();
});