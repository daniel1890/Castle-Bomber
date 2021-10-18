int startSchermKnopHoogte = 75;

// arrays die alle data bewaren wat betreft de knoppen die getekend worden op het start scherm.
int[] knopStart = {0, 500, schermBreedte, startSchermKnopHoogte, GEEL, VORM_BLOK, BLAUW};
int[][] spelersKnoppen = genereerKnoppenRij(aantalSpelers, 65);
int[][] schatKnoppen = genereerKnoppenRij(aantalSchatten, 215);
int[][] bommenDepotsKnoppen = genereerKnoppenRij(aantalBommenDepots, 365);

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


void verwerkMuisKlik_StartScherm(int muisX, int muisY) {
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
    spelStatus = SCHERM_SPEL;
    
    // setup spelborden wanneer alle gewilde instellingen geselecteerd zijn.
    spelBordSpeler1 = setupSpelBord(25, 10);
    spelBordSpeler2 = setupSpelBord(25, 10);
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
}
