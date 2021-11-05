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
