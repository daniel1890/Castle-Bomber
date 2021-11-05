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
int nMuren = 2;
int nSinkPools = 6;
int nRidders = 6;

// Index die bepaalt welke opties gekozen zijn in het hoofdmenu, door deze waarde globaal te maken kan je makkelijk de kleuren van de geselecteerde indexes veranderen.
int indexGekozenAantalSpelers = 0;
int indexGekozenAantalSchatten = 2;
int indexGekozenAantalBommenDepots = 2;

// Variabeles die de waarde van de hoofdmenu opties bevatten.
int gekozenAantalSpelers = aantalSpelers[indexGekozenAantalSpelers];
int gekozenAantalSchatten = aantalSchatten[indexGekozenAantalSchatten];
int gekozenAantalBommenDepots = aantalBommenDepots[indexGekozenAantalBommenDepots];

// Bepaal hoeveel cellen op het spelbord liggen in de x- en y-as.
int aantalGridCellsX = 12;
int aantalGridCellsY = 25;

// Bord dimensies
final int bordMargeTussen = schermBreedte / 20;
final int bordMargeBoven = 100;
final int bordBreedte = (schermBreedte - bordMargeTussen) / 2;
final int bordHoogte = schermHoogte - bordMargeBoven;

int clickedColSpeler1;
int clickedRijSpeler1;
int clickedColSpeler2;
int clickedRijSpeler2;

int scoreSpeler1 = 0;
int scoreSpeler2 = 0;
int aantalBommenStart = 20;
int aantalBommenSpeler1 = aantalBommenStart;
int aantalBommenSpeler2 = aantalBommenStart;

boolean tekenOpnieuw = true;

// Het bord voor beide spelers wat gevuld wordt met de spel elementen.
// SPELER 1 SPEELT TEGEN SPELBORD 1
// SPELER 2 SPEELT TEGEN SPELBORD 2
int[][] spelBordSpeler1;
int[][] spelBordSpeler2;

boolean speler1AanDeBeurt = true;
boolean speler2AanDeBeurt = !speler1AanDeBeurt;

boolean speler1Gewonnen = false;
boolean speler2Gewonnen = false;

boolean speler1Verloren = false;
boolean speler2Verloren = false;

/*
  Een methode die mbv de parameters bepaalt hoeveel rijen en columns getekend moeten worden, 
 hierna wordt een getallenlijst aangemaakt die even groot is dat als er cellen zitten in hoeveel rijen en columns er zijn,
 met de ontvangen array wordt bepaalt hoeveel rijen en columns er zijn, hierna wordt elke cell 1 voor 1 gevult met de geshuffelde lijst.
 */
int[][] setupSpelBord(int aantalRijen, int aantalCols) {
  int[][] spelBord = new int[aantalRijen][aantalCols];
  int aantalGetallen = aantalRijen * aantalCols;
  int[] getallenLijst = new int[aantalGetallen];

  // Creeër een variabele die elke keer 1 omhoog telt wanneer een element wordt toegevoegd aan de array,
  // deze kan je gebruiken in verschillende loops en de waarde blijft geupdated,  hiermee zorg je ervoor dat waardes niet in dezelfde cell geplaatst worden.
  int indexVulMetElementen = 0;

  /*
    Alle loops die nodig zijn om alle cellen met de verschillende elementen te vullen, eerst krijgt elke cell de GEDEKTECELL waarde 100,
   hierna wordt als er een element aan toegevoegd wordt de waarde van het ELEMENT opgeteld bij de GEDEKTECELL waarde.
   Om te zorgen dat de cellen getoond worden moet er een bom belanden op de cell, als dit gebeurt wordt er -100 opgeteld bij de waarde van de cell,
   hierdoor zal de waarde alleen nog de waarde van het ELEMENT bevatten en dan zal deze getoond worden aan de speler(s).
   */
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

// teken een spelbord op het scherm met alle nodige parameters.
void toonSpelBord(int[][] spelBord, float bordX, float bordY, float bordBreedte, float bordHoogte) {
  int aantalRijen = spelBord.length;
  int aantalKolommen = spelBord[0].length;

  // Cast deze waardes naar een int waarde omdat anders de afbeeldingen niet goed getekend worden binnen het grid.
  float celBreedte = bordBreedte / aantalKolommen;
  float celHoogte = bordHoogte / aantalRijen; 

  for (int rijTeller = 0; rijTeller < aantalRijen; rijTeller++) {
    for (int colTeller = 0; colTeller < aantalKolommen; colTeller++) {
      float x = bordX + colTeller * celBreedte;
      float y = bordY + rijTeller * celHoogte; 

      int kleur = #FAFAFA;

      //Standaard wordt een cell wit getekend, wanneer een cell omgedraait wordt krijgt de cell zijn werkelijke waarde: tussen 0 en 10.
      //Er wordt modulo gebruikt omdat cellen die niet getoond moeten worden een waarde boven de 100 hebben, wanneer een element score of bommen heeft toegevoegd moet deze uit het spel verwijdert worden zodat de puntentelling correct blijft
      //Dan wordt er 200 bij de cell opgeteld, doordat er met modulo gerekend is wordt de cell nog steeds juist getekend.
      if (spelBord[rijTeller][colTeller] < GEDEKTECELL || spelBord[rijTeller][colTeller] > VERWIJDER_ELEMENT) {
        if (spelBord[rijTeller][colTeller] == LEEG) {
          kleur = GROEN;
        } else if (spelBord[rijTeller][colTeller] % 100 == SCHAT) {
          kleur = BRUIN;
        } else if (spelBord[rijTeller][colTeller] % 100 == BOMDEPOT) {
          kleur = PAARS;
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
      //image(Zand, x, y, celBreedte, celHoogte);

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

// 2 simpele methodes om een geklikte rij en column te verkrijgen, werkt alleen met een gelijke 2 array, zodra de 2 array jagged is moet toch echt elke rij geteld worden mbv een for loop.
int verkrijgGeklikteColumn(int[][] spelBord, float spelBordX, float bordBreedte, float muisX) {
  int geklikteCol = NULL;

  float afstandX = muisX - spelBordX;
  float blokjesBreedte = bordBreedte / float(spelBord[0].length);
  boolean legitiemeKlik = afstandX > 0 && afstandX < bordBreedte;

  if (legitiemeKlik) {
    geklikteCol = floor((afstandX / blokjesBreedte));
  }

  return geklikteCol;
}

int verkrijgGeklikteRij(int[][] spelBord, float spelBordY, float bordHoogte, float muisY) {
  int geklikteRij = NULL;

  float afstandY = muisY - spelBordY;
  float blokjesHoogte = bordHoogte / float(spelBord.length);
  boolean legitiemeKlik = afstandY > 0 && afstandY < bordHoogte;

  if (legitiemeKlik) {
    geklikteRij = floor((afstandY / blokjesHoogte));
  }

  return geklikteRij;
}

// Een methode die een bom teruggooid naar de speler die niet aan de beurt is, want de ridder gooit de bom naar het andere veld met dezelfde column en rij.
int[][] ridderGooitBomTerug(int[][] spelBordSpelerGegooid, int[][] spelBordSpelerPassief, int clickedCol, int clickedRij) {
  if (spelBordSpelerGegooid[clickedRij][clickedCol] == RIDDER) {
    spelBordSpelerPassief = gooiBomOpBord(spelBordSpelerPassief, clickedCol, clickedRij);
  }

  if (clickedCol > 0) {
    if (spelBordSpelerGegooid[clickedRij][clickedCol - 1] == RIDDER) {
      spelBordSpelerPassief = gooiBomOpBord(spelBordSpelerPassief, clickedCol, clickedRij);
    }
  }

  if (clickedCol < spelBordSpelerGegooid[0].length - 1) {
    if (spelBordSpelerGegooid[clickedRij][clickedCol + 1] == RIDDER) {
      spelBordSpelerPassief = gooiBomOpBord(spelBordSpelerPassief, clickedCol, clickedRij);
    }
  }

  if (clickedRij > 0) {
    if (spelBordSpelerGegooid[clickedRij - 1][clickedCol] == RIDDER) {
      spelBordSpelerPassief = gooiBomOpBord(spelBordSpelerPassief, clickedCol, clickedRij);
    }
  }

  if (clickedRij < spelBordSpelerGegooid.length - 1) {
    if (spelBordSpelerGegooid[clickedRij + 1][clickedCol] == RIDDER) {
      spelBordSpelerPassief = gooiBomOpBord(spelBordSpelerPassief, clickedCol, clickedRij);
    }
  }

  return spelBordSpelerPassief;
}

// Deze methode ontvangt een spelbord en de geklikte column en rij binnen het meegegeven bord, aan de hand van het ELEMENT die binnen de geklikte cell ligt wordt bepaalt wat er precies gebeurt.
int[][] gooiBomOpBord(int[][] spelBord, int clickedCol, int clickedRij) {

  // Gooi alleen een bom op het bord wanneer de speler nog bommen heeft.
  // Als de speler op een sinkpool klikt print alleen "plons" en draai de cell niet om.
  if (spelBord[clickedRij][clickedCol] % 100 == SINKPOOL) {
    tekenPlonsAlsGebruikerSinkpoolRaakt(spelBord, clickedRij, clickedCol);
  }

  if (spelBord[clickedRij][clickedCol] >= GEDEKTECELL && spelBord[clickedRij][clickedCol] % 100 != SINKPOOL) {
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

// Een methode die plons in het scherm tekent op de muisX en muisY coördinaten van de gebruiker.
void tekenPlonsAlsGebruikerSinkpoolRaakt(int[][] spelBord, int clickedRij, int clickedCol) {
  if (spelBord[clickedRij][clickedCol] % 100 == SINKPOOL) {
    textSize(10);
    fill(#0000FF);
    text("plons", mouseX, mouseY);
  }
}

// Update de score van een speler wanneer de speler een veld met waarde SCHAT raakt, verwijder hierna het element uit het spel zodat deze niet meerdere keren bij de score opgeteld wordt.
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

// Update bommen van een speler met +3 wanneer een bom een bommendepot raakt, nadat de bommen geüpdated worden wordt het element uit het spel verwijdert zodat deze niet meerdere keren gelezen wordt.
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

// Als een van de cellen binnen het veld van een speler de waarde KONING bevat wordt het spel beeïndigd mbv een loop die door alle waardes heen loopt. 
boolean detecteerWinnendeStaat(int[][] spelBord, boolean winnendeStaatSpeler) {
  for (int rijTeller = 0; rijTeller < spelBord.length; rijTeller++) {
    for (int colTeller = 0; colTeller < spelBord[rijTeller].length; colTeller++) {
      if (spelBord[rijTeller][colTeller] == KONING) {
        winnendeStaatSpeler = true;
      }
    }
  }

  return winnendeStaatSpeler;
}



// Als een speler geen bommen meer heeft kan de speler geen bommen meer op het veld gooien.
boolean detecteerVerliezendeStaat(int aantalBommenSpeler, boolean verliezendeStaatSpeler) {
  verliezendeStaatSpeler = false;
  if (aantalBommenSpeler <= 0) {
    verliezendeStaatSpeler = true;
  }

  return verliezendeStaatSpeler;
}

// Een methode die water tekent in de achtergrond van het scherm.
void tekenWater(int startY, PImage img) {
  float celBreedte = 25;
  float celHoogte = 25; 
  startY+=1;

  for (int i = 0; i < 100; i++ ) {
    for (int j = 0; j < 100; j++) {
      image(img, 0 + celBreedte * i, startY + celHoogte * j, celBreedte, celHoogte);
    }
  }
}
