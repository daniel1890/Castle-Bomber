int startSchermKnopHoogte = 75;

// arrays die alle data bewaren wat betreft de knoppen die getekend worden op het start scherm.
int lengteKnopData = 8;
int[] knopStart = {0, 500, schermBreedte, startSchermKnopHoogte, GEEL, VORM_BLOK, BLAUW, 50};
int[][] spelersKnoppen = genereerKnoppenRij(aantalSpelers, 65, lengteKnopData);
int[][] schatKnoppen = genereerKnoppenRij(aantalSchatten, 215, lengteKnopData);
int[][] bommenDepotsKnoppen = genereerKnoppenRij(aantalBommenDepots, 365, lengteKnopData);

void toonStartScherm() {
  tekenKnop(knopStart, "START SPEL");
  tekenKnoppenRij(spelersKnoppen, aantalSpelers, indexGekozenAantalSpelers);
  tekenKnoppenRij(schatKnoppen, aantalSchatten, indexGekozenAantalSchatten);
  tekenKnoppenRij(bommenDepotsKnoppen, aantalBommenDepots, indexGekozenAantalBommenDepots);

  gekozenAantalSpelers = aantalSpelers[indexGekozenAantalSpelers];
  gekozenAantalSchatten = aantalSchatten[indexGekozenAantalSchatten];
  gekozenAantalBommenDepots = aantalBommenDepots[indexGekozenAantalBommenDepots];

  textAlign(CENTER, CENTER);
  textSize(50);
  fill(BLAUW);
  text("AANTAL SPELERS", schermBreedte / 2, 30);
  text("AANTAL SCHATTEN", schermBreedte / 2, 175);
  text("AANTAL BOMMENDEPOTS", schermBreedte / 2, 325);
}

void verwerkMuisKlik_StartScherm(float muisX, float muisY) {
  boolean raakStartKnop = verwerkMuisKlik_Knop(knopStart, muisX, muisY);

  // Maak een boolean array aan die evenveel plekken heeft als dat er knoppen zijn om te kiezen tussen aantal spelers, verwerk muisklik voor elke knop in de spelers array.
  boolean[] raakSpelersKnoppen = new boolean[aantalSpelers.length];
  for (int spelersIndex = 0; spelersIndex < aantalSpelers.length; spelersIndex++) {
    raakSpelersKnoppen[spelersIndex] = verwerkMuisKlik_Knop(spelersKnoppen[spelersIndex], muisX, muisY );
  }

  // Maak een boolean array aan die evenveel plekken heeft als dat er knoppen zijn om te kiezen tussen aantal schatten, verwerk muisklik voor elke knop in de schatknoppen array.
  boolean[] raakSchatKnoppen = new boolean[aantalSchatten.length];
  for (int schattenKnoppenIndex = 0; schattenKnoppenIndex < aantalSchatten.length; schattenKnoppenIndex++) {
    raakSchatKnoppen[schattenKnoppenIndex] = verwerkMuisKlik_Knop(schatKnoppen[schattenKnoppenIndex], muisX, muisY );
  }

  // Maak een boolean array aan die evenveel plekken heeft als dat er knoppen zijn om te kiezen tussen aantal bommen depots, verwerk muisklik voor elke knop in de bommendepotknoppen array.
  boolean[] raakBommenDepotsKnoppen = new boolean[aantalBommenDepots.length];
  for (int bommenDepotKnoppenIndex = 0; bommenDepotKnoppenIndex < aantalBommenDepots.length; bommenDepotKnoppenIndex++) {
    raakBommenDepotsKnoppen[bommenDepotKnoppenIndex] = verwerkMuisKlik_Knop(bommenDepotsKnoppen[bommenDepotKnoppenIndex], muisX, muisY );
  }

  // herken input op de start knop, wanneer deze ingedrukt wordt begint het spel
  if (raakStartKnop) {
    // setup spelborden wanneer alle gewilde instellingen geselecteerd zijn.
    spelBordSpeler1 = setupSpelBord(aantalGridCellsY, aantalGridCellsX);
    spelBordSpeler2 = setupSpelBord(aantalGridCellsY, aantalGridCellsX);

    // Reset alle waardes naar de startwaardes zodat alles netjes opnieuw begint.
    scoreSpeler1 = 0;
    scoreSpeler2 = 0;
    aantalBommenSpeler1 = aantalBommenStart;
    aantalBommenSpeler2 = aantalBommenStart;
    tekenVolgendeKnop = false;
    speler1Gewonnen = false;
    speler2Gewonnen = false;
    speler1Verloren = false;
    speler2Verloren = false;
    speler1AanDeBeurt = true;
    speler2AanDeBeurt = false;

    spelStatus = SCHERM_SPEL;
  }

  // Herken input in de rij waar de speler de hoeveelheid spelers kan bepalen, er wordt over elke knop gelooped.
  for (int indexSpelersKnop = 0; indexSpelersKnop < raakSpelersKnoppen.length; indexSpelersKnop++) {
    if (raakSpelersKnoppen[indexSpelersKnop]) {
      indexGekozenAantalSpelers = indexSpelersKnop;
    }
  }

  // Herken input in de rij waar de speler de hoeveelheid schatten kan bepalen, er wordt over elke knop gelooped.
  for (int indexSchatKnop = 0; indexSchatKnop < raakSchatKnoppen.length; indexSchatKnop++) {
    if (raakSchatKnoppen[indexSchatKnop]) {
      indexGekozenAantalSchatten = indexSchatKnop;
    }
  }

  for (int indexBommenDepotKnop = 0; indexBommenDepotKnop < raakBommenDepotsKnoppen.length; indexBommenDepotKnop++) {
    if (raakBommenDepotsKnoppen[indexBommenDepotKnop]) {
      indexGekozenAantalBommenDepots = indexBommenDepotKnop;
    }
  }

  tekenOpnieuw = true;
}
