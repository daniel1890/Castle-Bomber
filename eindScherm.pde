int[] knopOpnieuw = {0, 500, schermBreedte, 75, GEEL, 0, BLAUW};

void toonEindScherm() {
  println("In Eindscherm!!!");
  tekenKnop(knopOpnieuw, "SPEEL OPNIEUW");

  if (speler1Gewonnen || speler2Gewonnen) {
    String speler = "";
    int score = 0;
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(#0000FF);
    
    if (speler1Gewonnen) {
      speler = "SPELER 1";  
      score = scoreSpeler1;
    } else if (speler2Gewonnen) {
      speler = "SPELER 2";
      score = scoreSpeler2;
    }
    text(speler + " HEEFT GEWONNEN", schermBreedte / 2, 100);
    text("SCORE: " + score, schermBreedte / 2, 175);
  }
}

void verwerkMuisKlik_EindScherm(float muisX, float muisY) {
  boolean raakOpnieuwKnop = verwerkMuisKlik_Knop(knopOpnieuw, muisX, muisY);

  if (raakOpnieuwKnop) {
    spelStatus = 0;
  }
}
