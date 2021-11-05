int schermBreedte = 860;
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

final int KLEUR_SPELER1 = ORANJE;
final int KLEUR_SPELER2 = BLAUW;

// Afbeelding assets
PImage Koning;
PImage Schat;
PImage Ridder;
PImage Bom;
PImage Muur;
PImage Sinkpool;
PImage Leeg;
PImage Zand;

int spelStatus;

void settings() {
  size(schermBreedte, schermHoogte);
}

void setup() {
  Koning = loadImage("Crown.gif");
  Schat = loadImage("Schat.png");
  Ridder = loadImage("Knight.png");
  Bom = loadImage("Bombb.png");
  Muur = loadImage("Muur.png");
  Leeg = loadImage("Grass.png");
  Sinkpool = loadImage("Water.jpg");
  Zand = loadImage("Leegg.png");

  spelStatus = SCHERM_START;
}

void draw() {
  if (tekenOpnieuw) {
    // wis scherm
    background(0);

    switch (spelStatus) {
    case SCHERM_START:
      toonStartScherm();
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
  tekenOpnieuw = false;
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
    verwerkMuisKlik_EindScherm(muisX, muisY);
    break;
  default:
    println("FOUT: Er is iets fout gegaan!");
    break;
  }
}
