final int X = 0;
final int Y = 1;
final int BREEDTE = 2;
final int HOOGTE = 3;
final int KLEUR = 4;
final int VORM = 5;
final int TEKST_KLEUR = 6;

final int VORM_BLOK = 0;
final int VORM_ROND = 1;

// een methode die een enkele knop tekent, de knop ontvangt een array in de parameters die alle data bevat waarmee de knop getekend wordt.
void tekenKnop(int[] data, String tekst) {
  int x = data[X];
  int y = data[Y];
  int breedte = data[BREEDTE];
  int hoogte = data[HOOGTE];
  int kleur = data[KLEUR];
  int vorm = data[VORM];      // Dit wordt nu nog genegeerd
  int tekstKleur = data[TEKST_KLEUR];

  // voorbereidingen / berekeningen
  int tekstX = x + breedte / 2;
  int tekstY = y + hoogte / 2;

  // tekenen
  fill(kleur);
  rect(x, y, breedte, hoogte);

  fill(tekstKleur);  // TODO: tekstkleur meegeven
  textSize(50);   // TODO: tekstgrootte meegeven
  textAlign(CENTER, CENTER);
  text(tekst, tekstX, tekstY);
}


// een methode die een boolean waarde returned, de waarde die teruggegeven wordt is alleen true wanneer de gebruiker binnen de x en y coördinaten van de knop klikt dus er kan maar 1 knop tegelijk geklikt worden.
boolean verwerkMuisKlik_Knop(int[] knop, int muisX, int muisY) {
  int x = knop[X];
  int y = knop[Y];
  int breedte = knop[BREEDTE];
  int hoogte = knop[HOOGTE];

  boolean raakX = (muisX >= x && muisX <= x + breedte);
  boolean raakY = (muisY >= y && muisY <= y + hoogte);
  boolean raakKnop = raakX && raakY;

  return raakKnop;
}

// een methode die een 2d array creeërt met knoppen die getekend worden in een enkele rij, het aantal knoppen wordt bepaald door de lengte van de array die meegegeven wordt in de parameters.
int[][] genereerKnoppenRij(int[] data, int y) {

  int[][] knoppen = new int[data.length][7];
  int knopBreedte = schermBreedte / data.length;
  int knopHoogte = 75;

  for (int i = 0; i < knoppen.length; i++ ) {
    int[] enkeleKnopData = {0 + (i * knopBreedte), y, knopBreedte, knopHoogte, GEEL, VORM_BLOK, BLAUW };
    for (int j = 0; j < knoppen[i].length; j++) {
      knoppen[i][j] = enkeleKnopData[j];
    }
  }

  return knoppen;
}

// een methode die de knoppen tekent die gegenereerd worden door de genereerKnoppenRij methode.
void tekenKnoppenRij(int[][] knoppen, int[] data, int indexGekozen) {  
  for (int knopIndex = 0; knopIndex < data.length; knopIndex++) {
    knoppen[knopIndex][TEKST_KLEUR] = BLAUW;                                                     // teken de knop met de actieve index ROOD, alle andere knoppen worden BLAUW getekend
    knoppen[indexGekozen][TEKST_KLEUR] = ROOD;
    tekenKnop(knoppen[knopIndex], str(data[knopIndex]));
  }
}
