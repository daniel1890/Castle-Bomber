// Elementen waar het bord van de speler(s) gevuld mee wordt.
final int LEEG = 0;
final int SCHAT = 1;
final int RIDDER = 2;
final int BOMDEPOT = 3;
final int SINKPOOL = 4;
final int KONING = 5;
final int MUUR = 6;

// Vul elke cell met de waarde 100, tel hierbij op 1 van de elementen, de cellen worden alleen getoond wanneer de cellen een waarde bevatten die onder de 100 ligt, de waarde van de cell zal alleen -100 worden wanneer een bom op of om de cell explodeert.
final int GEDEKTECELL = 200;
final int TOONCELL = -200;
final int VERWIJDER_ELEMENT = 300;
final int NULL = -1;

// Arrays om te wisselen tussen de verschillende opties in het hoofdmenu
int[] aantalSpelers = { 1, 2 };
int[] aantalSchatten = { 10, 15, 20, 25, 30 };
int[] aantalBommenDepots = {3, 6, 9, 12, 15 };

// Waardes die bepalen hoeveel muren, sinkpools en ridders in het bord getekend worden.
int nMuren = 6;
int nSinkPools = 6;
int nRidders = 2;

// Index die bepaalt welke opties gekozen zijn in het hoofdmenu, door deze waarde globaal te maken kan je makkelijk de kleuren van de geselecteerde indexes veranderen.
int indexGekozenAantalSpelers = 0;
int indexGekozenAantalSchatten = 2;
int indexGekozenAantalBommenDepots = 2;

// Variabeles die de waarde van de hoofdmenu opties bevatten.
int gekozenAantalSpelers = aantalSpelers[indexGekozenAantalSpelers];
int gekozenAantalSchatten = aantalSchatten[indexGekozenAantalSchatten];
int gekozenAantalBommenDepots = aantalBommenDepots[indexGekozenAantalBommenDepots];

// Creeër een nieuw grid wat geshuffled wordt in de setup functie
int aantalGridCellsX = 10;
int aantalGridCellsY = 30;

// Bord dimensies
final float bordMargeTussen = schermBreedte / 20;
final float bordMargeBoven = 50;
final float bordBreedte = (schermBreedte - bordMargeTussen) / 2;
final float bordHoogte = schermHoogte - bordMargeBoven;

// Waardes die bijhouden welke column en rij de speler(s) voor het laatst hebben geklikt.
int[] clickedColEnRijSpeler1 = new int[2];
int[] clickedColEnRijSpeler2 = new int[2];

int clickedColSpeler1;
int clickedRijSpeler1;
int clickedColSpeler2;
int clickedRijSpeler2;

int scoreSpeler1 = 0;
int scoreSpeler2 = 0;
int aantalBommenSpeler1 = 30;
int aantalBommenSpeler2 = 30;

// Het bord voor beide spelers wat gevuld wordt met de spel elementen.
// SPELER 1 SPEELT TEGEN SPELBORD 1
// SPELER 2 SPEELT TEGEN SPELBORD 2
int[][] spelBordSpeler1;
int[][] spelBordSpeler2;

boolean speler1AanDeBeurt = true;
boolean speler2AanDeBeurt = !speler1AanDeBeurt;

boolean speler1Gewonnen = false;
boolean speler2Gewonnen = false;

// Een methode die mbv de parameters bepaalt hoeveel rijen en columns getekend moeten worden, hierna wordt een getallenlijst aangemaakt die even groot is dat als er cellen zitten in hoeveel rijen en columns er zijn,
// met de ontvangen array wordt bepaalt hoeveel rijen en columns er zijn, hierna wordt elke cell 1 voor 1 gevult met de geshuffelde lijst.
int[][] setupSpelBord(int aantalRijen, int aantalCols) {
  int[][] spelBord = new int[aantalRijen][aantalCols];
  int aantalGetallen = aantalRijen * aantalCols;
  int[] getallenLijst = new int[aantalGetallen];

  // Creeër een variabele die elke keer 1 omhoog telt wanneer een element wordt toegevoegd aan de array, deze kan je gebruiken in verschillende loops en de waarde blijft geupdated, hiermee zorg je ervoor dat waardes niet in dezelfde cell geplaatst worden.
  int indexVulMetElementen = 0;

  // Alle loops die nodig zijn om alle cellen met de verschillende elementen te vullen, eerst krijgt elke cell de GEDEKTECELL waarde 100, hierna wordt als er een element aan toegevoegd wordt de waarde van het ELEMENT opgeteld bij de GEDEKTECELL waarde.
  // Om te zorgen dat de cellen getoond worden moet er een bom belanden op de cell, als dit gebeurt wordt er -100 opgeteld bij de waarde van de cell, hierdoor zal de waarde alleen nog de waarde van het ELEMENT bevatten en dan zal deze getoond worden aan de speler(s).
  for (int getallenTeller = 0; getallenTeller < aantalGetallen; getallenTeller++) {
    getallenLijst[getallenTeller] += GEDEKTECELL + LEEG;
  }
  for (int schatTeller = 0; schatTeller < gekozenAantalSchatten; schatTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] += SCHAT;
  }
  for (int ridderTeller = 0; ridderTeller < nRidders; ridderTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] += RIDDER;
  }
  for (int murenTeller = 0; murenTeller < nMuren; murenTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] += MUUR;
  }
  for (int sinkPoolTeller = 0; sinkPoolTeller < nSinkPools; sinkPoolTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] += SINKPOOL;
  }
  for (int bommenDepotTeller = 0; bommenDepotTeller < gekozenAantalBommenDepots; bommenDepotTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] += BOMDEPOT;
  }

  indexVulMetElementen++;

  // Vul voor de laatste keer dat de index gebruikt wordt de laatste index met een koning.
  getallenLijst[indexVulMetElementen] += KONING;
  getallenLijst = shuffleGetallenLijst(getallenLijst, aantalGetallen);

  int counter = 0;

  for (int rijenTeller = 0; rijenTeller < aantalRijen; rijenTeller++) {
    for (int colTeller = 0; colTeller < aantalCols; colTeller++) {
      spelBord[rijenTeller][colTeller] = getallenLijst[counter];
      counter++;
    }
  }

  return spelBord;
}

// Deze functie shuffled een ontvangen array met getallen uit de array die op een andere plek staan, zie Fisher–Yates shuffle algoritme
int[] shuffleGetallenLijst(int getallenLijst[], int nGetallen) {         
  for (int getalIndex = nGetallen-1; getalIndex > 0; getalIndex--) {
    int randomIndex = int(random(getalIndex+1));
    int temp = getallenLijst[getalIndex];

    getallenLijst[getalIndex] = getallenLijst[randomIndex];
    getallenLijst[randomIndex] = temp;
  }

  return getallenLijst;
}

// teken een spelbord op het scherm met alle nodige parameters.
void toonSpelBord(int[][] spelBord, float bordX, float bordY, float bordBreedte, float bordHoogte) {
  int aantalRijen = spelBord.length;
  int aantalKolommen = spelBord[0].length;

  float celBreedte = bordBreedte / aantalKolommen;
  float celHoogte = bordHoogte / aantalRijen; 

  for (int rijTeller = 0; rijTeller < aantalRijen; rijTeller++) {
    for (int colTeller = 0; colTeller < aantalKolommen; colTeller++) {
      float x = bordX + colTeller * celBreedte;
      float y = bordY + rijTeller * celHoogte; 
      int kleur = #FFFFFF;

      // Standaard wordt een cell wit getekend, wanneer een cell omgedraait wordt krijgt de cell zijn werkelijke waarde: tussen 0 en 10.
      // Er wordt modulo gebruikt omdat cellen die niet getoond moeten worden een waarde boven de 100 hebben, wanneer een element score of bommen heeft toegevoegd moet deze uit het spel verwijdert worden zodat de puntentelling correct blijft
      // Dan wordt er 200 bij de cell opgeteld, doordat er met modulo gerekend is wordt de cell nog steeds juist getekend.
      if (spelBord[rijTeller][colTeller] < GEDEKTECELL || spelBord[rijTeller][colTeller] > VERWIJDER_ELEMENT) {
        if (spelBord[rijTeller][colTeller] == LEEG) {
          kleur = GROEN;
        } else if (spelBord[rijTeller][colTeller] % 100 == SCHAT) {
          kleur = PAARS;
        } else if (spelBord[rijTeller][colTeller] % 100 == BOMDEPOT) {
          kleur = BRUIN;
        } else if (spelBord[rijTeller][colTeller] == RIDDER) {
          kleur = ROOD;
        } else if (spelBord[rijTeller][colTeller] == KONING) {
          kleur = GEEL;
        } else if (spelBord[rijTeller][colTeller] == SINKPOOL) {
          kleur = BLAUW;
        } else if (spelBord[rijTeller][colTeller] == MUUR) {
          kleur = GRIJS;
        }
      }

      fill(kleur);
      rect(x, y, celBreedte, celHoogte);

      if (spelBord[rijTeller][colTeller] == KONING) {
        image(Koning, x, y, celBreedte, celHoogte);
      } else if (spelBord[rijTeller][colTeller] == SCHAT + VERWIJDER_ELEMENT) {
        image(Schat, x, y, celBreedte, celHoogte);
      } else if (spelBord[rijTeller][colTeller] == RIDDER) {
        image(Ridder, x, y, celBreedte, celHoogte);
      } else if (spelBord[rijTeller][colTeller] == BOMDEPOT + VERWIJDER_ELEMENT) {
        image(Bom, x, y, celBreedte, celHoogte);
      } else if (spelBord[rijTeller][colTeller] == MUUR) {
        image(Muur, x, y, celBreedte, celHoogte);
      } else if (spelBord[rijTeller][colTeller] == LEEG) {
        image(Leeg, x, y, celBreedte, celHoogte);
      } else if (spelBord[rijTeller][colTeller] == SINKPOOL) {
        image(Sinkpool, x, y, celBreedte, celHoogte);
      }
    }
  }
}

// Een functie die kliks op het grid detecteerd, met de coördinaten van de puzzle is makkelijk te bepalen waar de randen van elke cel liggen
int[] verkrijgGeklikteColEnRij(int[][] spelBord, int spelBordX, float spelBordY, float bordBreedte, float bordHoogte, float muisX, float muisY) {
  // Maak de waarde van beide variabelen standaard NULL zodat de waarde alleen herkend wordt wanneer deze aangepast wordt en dus niet meer NULL is.
  int[] colsRijenIndexes = { NULL, NULL };

  float afstandX = muisX - spelBordX;
  float afstandY = muisY - spelBordY;

  if (afstandX > 0 && afstandX < bordBreedte && afstandY > 0 && afstandY < bordHoogte) {
    for (int rijTeller = 0; rijTeller < spelBord.length; rijTeller++) {
      for (int colTeller = 0; colTeller < spelBord[rijTeller].length; colTeller++) {
        float blokjesHoogte = bordHoogte / float(spelBord.length);
        float blokjesBreedte = bordBreedte / float(spelBord[rijTeller].length);

        int colClicked = floor((afstandX / blokjesBreedte));
        int rijClicked = floor((afstandY / blokjesHoogte));

        colsRijenIndexes[0] = colClicked;
        colsRijenIndexes[1] = rijClicked;

        return colsRijenIndexes;
      }
    }
  }

  return colsRijenIndexes;
}

// Deze methode ontvangt een spelbord en de geklikte column en rij binnen het meegegeven bord, aan de hand van het ELEMENT die binnen de geklikte cell ligt wordt bepaalt wat er precies gebeurt.
int[][] gooiBomOpBord(int[][] spelBord, int clickedCol, int clickedRij) {

  if (spelBord[clickedRij][clickedCol] >= GEDEKTECELL) {
    spelBord[clickedRij][clickedCol] += TOONCELL;

    if (clickedCol > 0) {
      if (spelBord[clickedRij][clickedCol - 1] >= GEDEKTECELL && spelBord[clickedRij][clickedCol - 1] < VERWIJDER_ELEMENT) {
        spelBord[clickedRij][clickedCol - 1] += TOONCELL;
      }
    }

    if (clickedCol < spelBord[0].length - 1) {
      if (spelBord[clickedRij][clickedCol + 1] >= GEDEKTECELL&& spelBord[clickedRij][clickedCol + 1] < VERWIJDER_ELEMENT) {
        spelBord[clickedRij][clickedCol + 1] += TOONCELL;
      }
    }

    if (clickedRij > 0) {
      if (spelBord[clickedRij - 1][clickedCol] >= GEDEKTECELL&& spelBord[clickedRij - 1][clickedCol] < VERWIJDER_ELEMENT) {
        spelBord[clickedRij - 1][clickedCol] += TOONCELL;
      }
    }

    if (clickedRij < spelBord.length - 1) {
      if (spelBord[clickedRij + 1][clickedCol] >= GEDEKTECELL&& spelBord[clickedRij + 1][clickedCol] < VERWIJDER_ELEMENT) {
        spelBord[clickedRij + 1][clickedCol] += TOONCELL;
      }
    }
  }

  return spelBord;
}

int updateSpelerScore(int[][] spelBord, int scoreSpeler) {
  for (int rijTeller = 0; rijTeller < spelBord.length; rijTeller++) {
    for (int colTeller = 0; colTeller < spelBord[rijTeller].length; colTeller++) {
      if (spelBord[rijTeller][colTeller] == SCHAT) {

        scoreSpeler += 1;
        spelBord[rijTeller][colTeller] += VERWIJDER_ELEMENT;
      }
    }
  }

  return scoreSpeler;
}

int updateBommenSpeler(int[][] spelBord, int aantalBommenSpeler) {
  for (int rijTeller = 0; rijTeller < spelBord.length; rijTeller++) {
    for (int colTeller = 0; colTeller < spelBord[rijTeller].length; colTeller++) {
      if (spelBord[rijTeller][colTeller] == BOMDEPOT) {

        aantalBommenSpeler += 3;
        spelBord[rijTeller][colTeller] += VERWIJDER_ELEMENT;
      }
    }
  }

  return aantalBommenSpeler;
}

boolean detecteerWinnendeStaat(int[][] spelBord, boolean winnendeStaatSpeler) {
  for (int rijTeller = 0; rijTeller < spelBord.length; rijTeller++) {
    for (int colTeller = 0; colTeller < spelBord[rijTeller].length; colTeller++) {
      if (spelBord[rijTeller][colTeller] == KONING) {
        winnendeStaatSpeler = true;
        println("win");
      }
    }
  }
  
  return winnendeStaatSpeler;
}
