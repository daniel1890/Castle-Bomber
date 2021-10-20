void toonSpelScherm() {
  float startTekenX;

  if (gekozenAantalSpelers == 1) {
    startTekenX = schermBreedte / 2 - (schermBreedte / 4);

    toonSpelBord(spelBordSpeler1, startTekenX, bordMargeBoven, bordBreedte, bordHoogte);

    printSpelerEigenschap("SCORE: ", scoreSpeler1, (schermBreedte / 2) - (bordBreedte / 2.5), 25, KLEUR_SPELER1);
    printSpelerEigenschap("AANTAL BOMMEN: ", aantalBommenSpeler1, (schermBreedte / 2) + (bordBreedte / 5), 25, KLEUR_SPELER1);
  } else {
    startTekenX = 0;

    toonSpelBord(spelBordSpeler1, startTekenX, bordMargeBoven, bordBreedte, bordHoogte);
    toonSpelBord(spelBordSpeler2, startTekenX + bordBreedte + bordMargeTussen, bordMargeBoven, bordBreedte, bordHoogte);

    printSpelerEigenschap("SCORE: ", scoreSpeler1, (bordBreedte / 2) - (bordBreedte / 3), 25, KLEUR_SPELER1);
    printSpelerEigenschap("AANTAL BOMMEN: ", aantalBommenSpeler1, (bordBreedte / 2) + (bordBreedte / 5), 25, KLEUR_SPELER1);

    printSpelerEigenschap("SCORE: ", scoreSpeler2, bordBreedte + bordMargeTussen +(bordBreedte / 2) - (bordBreedte / 3), 25, KLEUR_SPELER2);
    printSpelerEigenschap("AANTAL BOMMEN: ", aantalBommenSpeler2, bordBreedte + bordMargeTussen +(bordBreedte / 2) + (bordBreedte / 5), 25, KLEUR_SPELER2);
  }
}

void verwerkMuisKlik_SpelScherm(float muisX, float muisY) {
  // Verwerk input voor een 1 speler spel
  if (gekozenAantalSpelers == 1) {
    clickedColEnRijSpeler1 = verkrijgGeklikteColEnRij(spelBordSpeler1, schermBreedte / 2 - (schermBreedte / 4), 50, 380, schermHoogte - 50, muisX, muisY);
    clickedColSpeler1 = clickedColEnRijSpeler1[0];
    clickedRijSpeler1 = clickedColEnRijSpeler1[1];

    boolean legitiemeKlikSpeler1 = clickedColEnRijSpeler1[0] != NULL && clickedColEnRijSpeler1[1] != NULL;

    // Controleer of de klikt col en rij array niet een NULL waarde bevat en voer alleen de bom methode uit wanneer de waardes legitiem zijn
    if (legitiemeKlikSpeler1) {
      // Registreer alleen muiskliks wanneer de speler klikt op een element wat nog niet getoond is.
      boolean isCellGedekt = spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] > MUUR && spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] < VERWIJDER_ELEMENT;
      if (isCellGedekt) {
        spelBordSpeler1 = gooiBomOpBord(spelBordSpeler1, clickedColSpeler1, clickedRijSpeler1);
        scoreSpeler1 = updateSpelerScore(spelBordSpeler1, scoreSpeler1);
        aantalBommenSpeler1 = updateBommenSpeler(spelBordSpeler1, aantalBommenSpeler1);
        aantalBommenSpeler1--;
        
        speler1Gewonnen = detecteerWinnendeStaat(spelBordSpeler1, speler1Gewonnen);
      }
    }
  } 
  // Verwerk input voor een 2 speler spel
  else {
    clickedColEnRijSpeler1 = verkrijgGeklikteColEnRij(spelBordSpeler1, 0, bordMargeBoven, bordBreedte, bordHoogte, muisX, muisY);
    clickedColSpeler1 = clickedColEnRijSpeler1[0];
    clickedRijSpeler1 = clickedColEnRijSpeler1[1];

    clickedColEnRijSpeler2 = verkrijgGeklikteColEnRij(spelBordSpeler2, 420, bordMargeBoven, bordBreedte, bordHoogte, muisX, muisY);
    clickedColSpeler2 = clickedColEnRijSpeler2[0];
    clickedRijSpeler2 = clickedColEnRijSpeler2[1];

    //clickedColEnRijSpeler1 = verkrijgGeklikteColEnRij(spelBordSpeler1, 0, 50, 380, schermHoogte - 50, muisX, muisY);
    //clickedColEnRijSpeler2 = verkrijgGeklikteColEnRij(spelBordSpeler2, 420, 50, 380, schermHoogte - 50, muisX, muisY);

    boolean legitiemeKlikSpeler1 = clickedColEnRijSpeler1[0] != NULL && clickedColEnRijSpeler1[1] != NULL;
    boolean legitiemeKlikSpeler2 = clickedColEnRijSpeler2[0] != NULL && clickedColEnRijSpeler2[1] != NULL;

    if (speler1AanDeBeurt) {
      if (legitiemeKlikSpeler1) {
        boolean isCellGedekt = spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] > MUUR && spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] < VERWIJDER_ELEMENT;
        if (isCellGedekt) {
          spelBordSpeler1 = gooiBomOpBord(spelBordSpeler1, clickedColSpeler1, clickedRijSpeler1);
          scoreSpeler1 = updateSpelerScore(spelBordSpeler1, scoreSpeler1);
          aantalBommenSpeler1 = updateBommenSpeler(spelBordSpeler1, aantalBommenSpeler1);
          aantalBommenSpeler1--;
          
          speler1Gewonnen = detecteerWinnendeStaat(spelBordSpeler1, speler1Gewonnen);

          // Switch de beurt van de spelers nadat alle methodes uitgevoerd zijn
          speler1AanDeBeurt = !speler1AanDeBeurt;
          speler2AanDeBeurt = !speler2AanDeBeurt;
        }
      }
    }

    if (speler2AanDeBeurt) {
      if (legitiemeKlikSpeler2) {
        boolean isCellGedekt = spelBordSpeler2[clickedRijSpeler2][clickedColSpeler2] > MUUR && spelBordSpeler2[clickedRijSpeler2][clickedColSpeler2] < VERWIJDER_ELEMENT;
        if (isCellGedekt) {
          spelBordSpeler2 = gooiBomOpBord(spelBordSpeler2, clickedColSpeler2, clickedRijSpeler2);
          scoreSpeler2 = updateSpelerScore(spelBordSpeler2, scoreSpeler2);
          aantalBommenSpeler2 = updateBommenSpeler(spelBordSpeler2, aantalBommenSpeler2);
          aantalBommenSpeler2--;
          
          speler2Gewonnen = detecteerWinnendeStaat(spelBordSpeler2, speler2Gewonnen);

          speler2AanDeBeurt = !speler2AanDeBeurt;
          speler1AanDeBeurt = !speler1AanDeBeurt;
        }
      }
    }
  }
  
  // Als speler 1 of 2 gewonnen heeft beweeg naar het eindscherm.
  if (speler1Gewonnen || speler2Gewonnen) {
    delay(2000);
    spelStatus = SCHERM_EIND;  
  }
}

//void printEigenschappenSpeler(int) {
//  printSpelerScore    
//}

void printSpelerEigenschap(String tekst, int scoreSpeler, float x, float y, int kleurSpeler) {
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(kleurSpeler);
  text(tekst + scoreSpeler, x, y);
}
