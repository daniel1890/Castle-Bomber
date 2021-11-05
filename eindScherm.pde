int[] knopOpnieuw = {0, 500, schermBreedte, 75, GEEL, 0, BLAUW, 50};

void toonEindScherm() {
  println("In Eindscherm!!!");
  tekenKnop(knopOpnieuw, "SPEEL OPNIEUW");

  if (speler1Gewonnen || speler2Gewonnen) {
    String speler = "";
    int score = 0;
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(#0000FF);

    if (speler1Gewonnen && speler2Gewonnen) {
      text("SPELER 1 HEEFT GEWONNEN", schermBreedte / 2, 100);
      text("SCORE: " + scoreSpeler1, schermBreedte / 2, 175);
      text("SPELER 2 HEEFT GEWONNEN", schermBreedte / 2, 300);
      text("SCORE: " + scoreSpeler2, schermBreedte / 2, 375);
    } else if (speler1Gewonnen) {
      speler = "SPELER 1";  
      score = scoreSpeler1;
      text(speler + " HEEFT GEWONNEN", schermBreedte / 2, 200);
      text("SCORE: " + score, schermBreedte / 2, 275);
    } else if (speler2Gewonnen) {
      speler = "SPELER 2";
      score = scoreSpeler2;
      text(speler + " HEEFT GEWONNEN", schermBreedte / 2, 200);
      text("SCORE: " + score, schermBreedte / 2, 275);
    }
  } else if (speler1Verloren || speler2Verloren) {
    String speler1 = "SPELER 1";
    String speler2 = "SPELER 2";
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(#0000FF);

    if (speler1Verloren && speler2Verloren) {
      text(speler1 + " HEEFT VERLOREN", schermBreedte / 2, 100);
      text("SCORE: " + scoreSpeler1, schermBreedte / 2, 175);
      text(speler2 + " HEEFT VERLOREN", schermBreedte / 2, 300);
      text("SCORE: " + scoreSpeler2, schermBreedte / 2, 375);
    } else if (speler1Verloren) {
      text(speler1 + " HEEFT VERLOREN", schermBreedte / 2, 200);
      text("SCORE: " + scoreSpeler1, schermBreedte / 2, 275);
    }
  }

  tekenOpnieuw = false;
}

void verwerkMuisKlik_EindScherm(float muisX, float muisY) {
  boolean raakOpnieuwKnop = verwerkMuisKlik_Knop(knopOpnieuw, muisX, muisY);

  if (raakOpnieuwKnop) {
    spelStatus = 0;
    tekenOpnieuw = true;
  }
}
