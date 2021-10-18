void toonSpelScherm() {
  int startTekenX;

  if (gekozenAantalSpelers == 1) {
    startTekenX = schermBreedte / 2 - (schermBreedte / 4);
    toonSpelBord(spelBordSpeler1, startTekenX, int(bordMargeBoven), bordBreedte, bordHoogte);
  } else {
    startTekenX = 0;
    toonSpelBord(spelBordSpeler1, startTekenX, int(bordMargeBoven), bordBreedte, bordHoogte);
    toonSpelBord(spelBordSpeler2, startTekenX + int(bordBreedte + bordMargeTussen), int(bordMargeBoven), bordBreedte, bordHoogte);
  }
}

void verwerkMuisKlik_SpelScherm(float muisX, float muisY) {
  if (gekozenAantalSpelers == 1) {
    clickedColEnRijSpeler1 = verkrijgGeklikteColEnRij(spelBordSpeler1, schermBreedte / 2 - (schermBreedte / 4), 50, 380, schermHoogte - 50, muisX, muisY);
    clickedColSpeler1 = clickedColEnRijSpeler1[0];
    clickedRijSpeler1 = clickedColEnRijSpeler1[1];

    // Controleer of de klikt col en rij array niet een NULL waarde bevat en voer alleen de bom methode uit wanneer de waardes legitiem zijn
    if (clickedColEnRijSpeler1[0] != NULL && clickedColEnRijSpeler1[1] != NULL) {
      spelBordSpeler1 = gooiBomOpBord(spelBordSpeler1, clickedColSpeler1, clickedRijSpeler1);
    }
  } else {
    clickedColEnRijSpeler1 = verkrijgGeklikteColEnRij(spelBordSpeler1, 0, int(bordMargeBoven), bordBreedte, bordHoogte, muisX, muisY);
    clickedColSpeler1 = clickedColEnRijSpeler1[0];
    clickedRijSpeler1 = clickedColEnRijSpeler1[1];

    clickedColEnRijSpeler2 = verkrijgGeklikteColEnRij(spelBordSpeler2, 420, int(bordMargeBoven), bordBreedte, bordHoogte, muisX, muisY);
    clickedColSpeler2 = clickedColEnRijSpeler2[0];
    clickedRijSpeler2 = clickedColEnRijSpeler2[1];

    clickedColEnRijSpeler1 = verkrijgGeklikteColEnRij(spelBordSpeler1, 0, 50, 380, schermHoogte - 50, muisX, muisY);
    clickedColEnRijSpeler2 = verkrijgGeklikteColEnRij(spelBordSpeler2, 420, 50, 380, schermHoogte - 50, muisX, muisY);

    
    if (speler1AanDeBeurt) {
      if (clickedColEnRijSpeler1[0] != NULL && clickedColEnRijSpeler1[1] != NULL) {
        spelBordSpeler1 = gooiBomOpBord(spelBordSpeler1, clickedColSpeler1, clickedRijSpeler1);
        speler1AanDeBeurt = !speler1AanDeBeurt;
        speler2AanDeBeurt = !speler2AanDeBeurt;
      }
    }

    // Controleer of de klikt col en rij array niet een NULL waarde bevat en voer alleen de bom methode uit wanneer de waardes legitiem zijn
    if (speler2AanDeBeurt) {
      if (clickedColEnRijSpeler2[0] != NULL && clickedColEnRijSpeler2[1] != NULL) {
        spelBordSpeler2 = gooiBomOpBord(spelBordSpeler2, clickedColSpeler2, clickedRijSpeler2);
        speler2AanDeBeurt = !speler2AanDeBeurt;
        speler1AanDeBeurt = !speler1AanDeBeurt;
      }
    }
  }
}
