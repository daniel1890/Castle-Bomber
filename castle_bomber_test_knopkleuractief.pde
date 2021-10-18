int schermBreedte = 800;
int schermHoogte = 600;

final int SCHERM_START = 0;
final int SCHERM_SPEL  = 1;
final int SCHERM_EIND  = 2;

final int ROOD = #FF0000;
final int GEEL = #FFFF00;
final int BLAUW = #0000FF;
final int GRIJS = 155;
final int BRUIN = #6C5209;
final int PAARS = #B900B1;
final int WIT = #FFFFFF;
final int GROEN = #1DB200;
final int ORANJE = #F7A948;

final int KLEUR_SPELER1 = GROEN;
final int KLEUR_SPELER2 = ORANJE;

int spelStatus;


void settings() {
  size(schermBreedte, schermHoogte);
}

void setup() {
  spelStatus = SCHERM_START;
}

void draw() {
  // wis scherm
  background(0);

  switch (spelStatus) {
  case SCHERM_START:
    toonStartScherm();
    //println(gekozenAantalSchatten);
    //println(gekozenAantalBommenDepots);
    //println(gekozenAantalSpelers);
    break;
  case SCHERM_SPEL:
    toonSpelScherm();
    break;
  case SCHERM_EIND:
    toonEindScherm();
    break;
  default:
    // hier kunnen we eigenlijk niet komen
    println("FOUT: Er is iets fout gegaan!");
    break;
  }
}

void mouseClicked() {
  float muisX = mouseX;
  float muisY = mouseY;

  switch (spelStatus) {
  case SCHERM_START:
    verwerkMuisKlik_StartScherm(muisX, muisY);
    break;
  case SCHERM_SPEL:
    verwerkMuisKlik_SpelScherm(muisX, muisY);
    break;
  case SCHERM_EIND:

    break;
  default:
    println("FOUT: Er is iets fout gegaan!");
    break;
  }
}
