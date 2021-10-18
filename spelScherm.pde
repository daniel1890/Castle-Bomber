void toonSpelScherm() {
  int startTekenX;

  if (gekozenAantalSpelers == 1) {
    startTekenX = schermBreedte / 2 - (schermBreedte / 4);
    toonSpelBord(spelBordSpeler1, startTekenX, 50, 380, schermHoogte - 50);
  } else {
    startTekenX = 0;
    toonSpelBord(spelBordSpeler1, startTekenX, 50, 380, schermHoogte - 50);
    toonSpelBord(spelBordSpeler2, startTekenX + 420, 50, 380, schermHoogte - 50);
  }
  
}
