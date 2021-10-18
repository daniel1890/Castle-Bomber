final int LEEG = 0;
final int SCHAT = 1;
final int RIDDER = 2;
final int BOMDEPOT = 3;
final int SINKPOOL = 4;
final int KONING = 5;
final int MUUR = 6;

int[] aantalSpelers = { 1, 2 };
int[] aantalSchatten = { 10, 15, 20, 25, 30 };
int[] aantalBommenDepots = {3, 6, 9, 12, 15 };
int nMuren = 6;
int nSinkPools = 6;
int nRidders = 2;

int indexGekozenAantalSpelers = 0;
int indexGekozenAantalSchatten = 2;
int indexGekozenAantalBommenDepots = 2;

int gekozenAantalSpelers = aantalSpelers[indexGekozenAantalSpelers];
int gekozenAantalSchatten = aantalSchatten[indexGekozenAantalSchatten];
int gekozenAantalBommenDepots = aantalBommenDepots[indexGekozenAantalBommenDepots];

// Creeër een nieuw grid wat geshuffled wordt in de setup functie
int aantalGridCellsX = 10;
int aantalGridCellsY = 25;

int[][] spelBordSpeler1;
int[][] spelBordSpeler2;

// Vul een spelbord met lege cellen, vul ze hierna met alle andere elementen.
int[][] vulSpelBord(int[][] bord) {
  for (int rijTeller = 0; rijTeller < bord.length; rijTeller++) {
    for (int colTeller = 0; colTeller < bord[rijTeller].length; colTeller++) {
      bord[rijTeller][colTeller] = LEEG;
    }
  }

  return bord;
}

// Een methode die mbv de parameters bepaalt hoeveel rijen en columns getekend moeten worden, hierna wordt een getallenlijst aangemaakt die even groot is dat als er cellen zitten in hoeveel rijen en columns er zijn,
// met de ontvangen array wordt bepaalt hoeveel rijen en columns er zijn, hierna wordt elke cell 1 voor 1 gevult met de geshuffelde lijst.
int[][] setupSpelBord(int aantalRijen, int aantalCols) {
  int[][] spelBord = new int[aantalRijen][aantalCols];
  int aantalGetallen = aantalRijen * aantalCols;
  int[] getallenLijst = new int[aantalGetallen];

  // Creeër een variabele die elke keer 1 omhoog telt wanneer een element wordt toegevoegd aan de array, deze kan je gebruiken in verschillende loops en de waarde blijft geupdated, hiermee zorg je ervoor dat waardes niet in dezelfde cell geplaatst worden.
  int indexVulMetElementen = 0;

  for (int getallenTeller = 0; getallenTeller < aantalGetallen; getallenTeller++) {
    getallenLijst[getallenTeller] = LEEG;
  }

  for (int schatTeller = 0; schatTeller < gekozenAantalSchatten; schatTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] = SCHAT;
    println(indexVulMetElementen);
  }

  for (int ridderTeller = 0; ridderTeller < nRidders; ridderTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] = RIDDER;
    println(indexVulMetElementen);
  }
  
    for (int murenTeller = 0; murenTeller < nMuren; murenTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] = MUUR;
    println(indexVulMetElementen);
  }
  
    for (int sinkPoolTeller = 0; sinkPoolTeller < nSinkPools; sinkPoolTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] = SINKPOOL;
    println(indexVulMetElementen);
  }
  
    for (int bommenDepotTeller = 0; bommenDepotTeller < gekozenAantalBommenDepots; bommenDepotTeller++) {
    indexVulMetElementen++;

    getallenLijst[indexVulMetElementen] = BOMDEPOT;
    println(indexVulMetElementen);
  }
  
  indexVulMetElementen++;
  // Vul voor de laatste keer dat de index gebruikt wordt de laatste index met een koning.
  getallenLijst[indexVulMetElementen] = KONING;

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
  for (int i = nGetallen-1; i > 0; i--) {
    int randomIndex = int(random(i+1));
    int temp = getallenLijst[i];

    getallenLijst[i] = getallenLijst[randomIndex];
    getallenLijst[randomIndex] = temp;
  }

  return getallenLijst;
}

// teken een spelbord op het scherm met alle nodige parameters.
void toonSpelBord(int[][] spelBord, int bordX, int bordY, int bordBreedte, int bordHoogte) {
  int aantalRijen = spelBord.length;
  int aantalKolommen = spelBord[0].length;

  int celBreedte = bordBreedte / aantalKolommen;
  int celHoogte = bordHoogte / aantalRijen; 

  for (int rijTeller = 0; rijTeller < aantalRijen; rijTeller++) {
    for (int colTeller = 0; colTeller < aantalKolommen; colTeller++) {
      int x = bordX + colTeller * celBreedte;
      int y = bordY + rijTeller * celHoogte; 
      int kleur = #FFFFFF;

      if (spelBord[rijTeller][colTeller] == LEEG) {
        kleur = WIT;
      } else if (spelBord[rijTeller][colTeller] == SCHAT) {
        kleur = PAARS;
      } else if (spelBord[rijTeller][colTeller] == BOMDEPOT) {
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
      fill(kleur);
      rect(x, y, celBreedte, celHoogte);
    }
  }
}
