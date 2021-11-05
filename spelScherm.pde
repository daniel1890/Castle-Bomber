// Maak een knop aan die alleen weergeven wordt wanneer het spel voorbij is.
boolean tekenVolgendeKnop = false;
int volgendeKnopBreedte = schermBreedte / 8;
int[] knopVolgende = {schermBreedte - (volgendeKnopBreedte), 30, volgendeKnopBreedte, 35, GEEL, VORM_BLOK, BLAUW, 10};

void toonSpelScherm() {
  float startTekenX;

  if (gekozenAantalSpelers == 1) {
    startTekenX = schermBreedte / 2 - (schermBreedte / 4);

    tekenWater(bordMargeBoven, Sinkpool);
    toonSpelBord(spelBordSpeler1, startTekenX, bordMargeBoven, bordBreedte, bordHoogte);

    printSpelerEigenschap("SCORE: ", scoreSpeler1, (schermBreedte / 2) - (bordBreedte / 2.5), 75, KLEUR_SPELER1, 20);
    printSpelerEigenschap("AANTAL BOMMEN: ", aantalBommenSpeler1, (schermBreedte / 2) + (bordBreedte / 5), 75, KLEUR_SPELER1, 20);

    textSize(25);
    fill(KLEUR_SPELER1);
    text("SPELER 1", schermBreedte / 2, 25);

    // Print gewonnen of verloren op het bord wanneer de speler zijn laatste zet gemaakt heeft.
    if (speler1Gewonnen) {
      textSize(25);
      fill(KLEUR_SPELER1);
      text("GEWONNEN", schermBreedte / 2, schermHoogte / 2);
    } else if (speler1Verloren) {
      textSize(25);
      fill(ROOD);
      text("VERLOREN", schermBreedte / 2, schermHoogte / 2);
    }
  } else {
    startTekenX = 0;
    float lijnBreedte = schermBreedte / 10;
    float lijnStartY = bordMargeBoven / 2;

    tekenWater(bordMargeBoven, Sinkpool);
    toonSpelBord(spelBordSpeler1, startTekenX, bordMargeBoven, bordBreedte, bordHoogte);
    toonSpelBord(spelBordSpeler2, startTekenX + bordBreedte + bordMargeTussen, bordMargeBoven, bordBreedte, bordHoogte);

    printSpelerEigenschap("SCORE: ", scoreSpeler1, (bordBreedte / 2) - (bordBreedte / 3), 75, KLEUR_SPELER1, 20);
    printSpelerEigenschap("AANTAL BOMMEN: ", aantalBommenSpeler1, (bordBreedte / 2) + (bordBreedte / 5), 75, KLEUR_SPELER1, 20);

    printSpelerEigenschap("SCORE: ", scoreSpeler2, bordBreedte + bordMargeTussen +(bordBreedte / 2) - (bordBreedte / 3), 75, KLEUR_SPELER2, 20);
    printSpelerEigenschap("AANTAL BOMMEN: ", aantalBommenSpeler2, bordBreedte + bordMargeTussen +(bordBreedte / 2) + (bordBreedte / 5), 75, KLEUR_SPELER2, 20);

    textSize(25);
    fill(KLEUR_SPELER1);
    text("SPELER 1", bordBreedte / 2, 25);
    fill(KLEUR_SPELER2);
    text("SPELER 2", bordBreedte + bordMargeTussen + (bordBreedte / 2), 25);
    
    if (speler1AanDeBeurt) {
      stroke(KLEUR_SPELER1);
      strokeWeight(5);
      line((bordBreedte / 2) - lijnBreedte, lijnStartY, bordBreedte / 2 + lijnBreedte, lijnStartY);
      stroke(0);
      strokeWeight(1);
    } else if (speler2AanDeBeurt) {
      stroke(KLEUR_SPELER2);
      strokeWeight(5);
      line(bordBreedte + bordMargeTussen + (bordBreedte / 2) - lijnBreedte, lijnStartY, bordBreedte + bordMargeTussen + (bordBreedte / 2) + lijnBreedte, lijnStartY);
      stroke(0);
      strokeWeight(1);
    }
    if (speler1Gewonnen) {
      textSize(25);
      fill(KLEUR_SPELER1);
      text("GEWONNEN", startTekenX + (bordBreedte / 2), schermHoogte / 2);
    } else if (speler1Verloren) {
      textSize(25);
      fill(ROOD);
      text("VERLOREN", startTekenX + (bordBreedte / 2), schermHoogte / 2);
    }
    if (speler2Gewonnen) {
      textSize(25);
      fill(KLEUR_SPELER2);
      text("GEWONNEN", startTekenX + bordBreedte + bordMargeTussen + (bordBreedte / 2), schermHoogte / 2);
    } else if (speler2Verloren) {
      textSize(25);
      fill(ROOD);
      text("VERLOREN", startTekenX + bordBreedte + bordMargeTussen + (bordBreedte / 2), schermHoogte / 2);
    }
  }

  if (tekenVolgendeKnop) {
    tekenKnop(knopVolgende, "VOLGEND SCHERM");
  }
}

void verwerkMuisKlik_SpelScherm(float muisX, float muisY) {

  boolean raakVolgendeKnop = verwerkMuisKlik_Knop(knopVolgende, muisX, muisY);

  if (raakVolgendeKnop) {
    spelStatus = SCHERM_EIND;
  }

  // Verwerk input voor een 1 speler spel
  if (gekozenAantalSpelers == 1) {
    // Verkrijg geklikte column en rij voor speler 1.
    clickedColSpeler1 = verkrijgGeklikteColumn(spelBordSpeler1, schermBreedte / 2 - (schermBreedte / 4), bordBreedte, muisX);
    clickedRijSpeler1 = verkrijgGeklikteRij(spelBordSpeler1, bordMargeBoven, bordHoogte, muisY);

    // Bepaal of speler 1 een legitieme klik gemaakt heeft.
    boolean legitiemeKlikSpeler1 = clickedColSpeler1 != NULL && clickedRijSpeler1 != NULL;

    // Controleer of de klikt col en rij array niet een NULL waarde bevat en voer alleen de bom methode uit wanneer de waardes legitiem zijn
    if (legitiemeKlikSpeler1 && aantalBommenSpeler1 >= 1 && !speler1Verloren && !speler1Gewonnen) {
      // Registreer alleen muiskliks wanneer de speler klikt op een element wat nog niet getoond is.
      boolean isCellGedekt = spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] > MUUR && spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] < VERWIJDER_ELEMENT;
      if (isCellGedekt) {
        spelBordSpeler1 = gooiBomOpBord(spelBordSpeler1, clickedColSpeler1, clickedRijSpeler1);
        scoreSpeler1 = updateSpelerScore(spelBordSpeler1, scoreSpeler1);
        aantalBommenSpeler1 = updateBommenSpeler(spelBordSpeler1, aantalBommenSpeler1);
        aantalBommenSpeler1--;

        speler1Gewonnen = detecteerWinnendeStaat(spelBordSpeler1, speler1Gewonnen);
        speler1Verloren = detecteerVerliezendeStaat(aantalBommenSpeler1, speler1Verloren);
      }
    }
  } 
  // Verwerk input voor een 2 speler spel
  else {
    // Verkrijg geklikte column en rij voor speler 1.
    clickedColSpeler1 = verkrijgGeklikteColumn(spelBordSpeler1, 0, bordBreedte, muisX);
    clickedRijSpeler1 = verkrijgGeklikteRij(spelBordSpeler1, bordMargeBoven, bordHoogte, muisY);

    // Verkrijg geklikte column en rij voor speler 2.
    clickedColSpeler2 = verkrijgGeklikteColumn(spelBordSpeler2, 0 + bordBreedte + bordMargeTussen, bordBreedte, muisX);
    clickedRijSpeler2 = verkrijgGeklikteRij(spelBordSpeler2, bordMargeBoven, bordHoogte, muisY);

    // Bepaal of speler 1/2 een legitieme klik gemaakt heeft.
    boolean legitiemeKlikSpeler1 = clickedColSpeler1 != NULL && clickedRijSpeler1 != NULL;
    boolean legitiemeKlikSpeler2 = clickedColSpeler2 != NULL && clickedRijSpeler2 != NULL;

    if (speler1AanDeBeurt) {
      if (legitiemeKlikSpeler1 && aantalBommenSpeler1 >= 1 && !speler1Verloren && !speler1Gewonnen) {
        boolean isCellGedekt = spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] > MUUR && spelBordSpeler1[clickedRijSpeler1][clickedColSpeler1] < VERWIJDER_ELEMENT;
        if (isCellGedekt) {
          spelBordSpeler1 = gooiBomOpBord(spelBordSpeler1, clickedColSpeler1, clickedRijSpeler1);
          spelBordSpeler2 = ridderGooitBomTerug(spelBordSpeler1, spelBordSpeler2, clickedColSpeler1, clickedRijSpeler1);
          scoreSpeler1 = updateSpelerScore(spelBordSpeler1, scoreSpeler1);
          scoreSpeler2 = updateSpelerScore(spelBordSpeler2, scoreSpeler2);
          aantalBommenSpeler1 = updateBommenSpeler(spelBordSpeler1, aantalBommenSpeler1);
          aantalBommenSpeler2 = updateBommenSpeler(spelBordSpeler2, aantalBommenSpeler2);
          aantalBommenSpeler1--;

          speler1Gewonnen = detecteerWinnendeStaat(spelBordSpeler1, speler1Gewonnen);
          speler2Gewonnen = detecteerWinnendeStaat(spelBordSpeler2, speler2Gewonnen);
          speler1Verloren = detecteerVerliezendeStaat(aantalBommenSpeler1, speler1Verloren);

          // Switch de beurt van de spelers nadat alle methodes uitgevoerd zijn en alleen wanneer speler 2 nog niet verloren heeft.
          if (!speler2Verloren && !speler2Gewonnen) {
            speler1AanDeBeurt = !speler1AanDeBeurt;
            speler2AanDeBeurt = !speler2AanDeBeurt;
          }
        }
      }
    }

    if (speler2AanDeBeurt) {
      if (legitiemeKlikSpeler2 && aantalBommenSpeler2 >= 1 && !speler2Verloren && !speler2Gewonnen) {
        boolean isCellGedekt = spelBordSpeler2[clickedRijSpeler2][clickedColSpeler2] > MUUR && spelBordSpeler2[clickedRijSpeler2][clickedColSpeler2] < VERWIJDER_ELEMENT;
        if (isCellGedekt) {
          spelBordSpeler2 = gooiBomOpBord(spelBordSpeler2, clickedColSpeler2, clickedRijSpeler2);
          spelBordSpeler1 = ridderGooitBomTerug(spelBordSpeler2, spelBordSpeler1, clickedColSpeler2, clickedRijSpeler2);
          scoreSpeler2 = updateSpelerScore(spelBordSpeler2, scoreSpeler2);
          scoreSpeler1 = updateSpelerScore(spelBordSpeler1, scoreSpeler1);
          aantalBommenSpeler2 = updateBommenSpeler(spelBordSpeler2, aantalBommenSpeler2);
          aantalBommenSpeler1 = updateBommenSpeler(spelBordSpeler1, aantalBommenSpeler1);
          aantalBommenSpeler2--;

          speler2Gewonnen = detecteerWinnendeStaat(spelBordSpeler2, speler2Gewonnen);
          speler1Gewonnen = detecteerWinnendeStaat(spelBordSpeler1, speler1Gewonnen);
          speler2Verloren = detecteerVerliezendeStaat(aantalBommenSpeler2, speler2Verloren);

          if (!speler1Verloren && !speler1Gewonnen) {
            speler2AanDeBeurt = !speler2AanDeBeurt;
            speler1AanDeBeurt = !speler1AanDeBeurt;
          }
        }
      }
    }
  }

  if (gekozenAantalSpelers == 1 && (speler1Gewonnen || speler1Verloren)) {
    tekenVolgendeKnop = true;
  } else if (gekozenAantalSpelers == 2 && ((speler1Gewonnen || speler2Gewonnen) || (speler1Verloren && speler2Verloren))) {
    tekenVolgendeKnop = true;
  }

  tekenOpnieuw = true;
}

void printSpelerEigenschap(String tekst, int scoreSpeler, float x, float y, int kleurSpeler, int tekstGrootte) {
  textSize(tekstGrootte);
  textAlign(CENTER, CENTER);
  fill(kleurSpeler);
  text(tekst + scoreSpeler, x, y);
}
