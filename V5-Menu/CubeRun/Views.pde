class Views {
  public Views() {}
  
  void pauseGame() {
    pushMatrix();
    camera();
    textSize(40);
    fill(255);
    text("PAUSA", width/2, height/2);
    popMatrix();
  } 
}
