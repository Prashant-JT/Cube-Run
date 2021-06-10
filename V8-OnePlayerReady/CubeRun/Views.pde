class Views {
  public Views() {}
  
  void pauseGame() {
    pushMatrix();
    camera();
    textSize(40);
    fill(255);
    text("PAUSE", width/2, height/2);
    popMatrix();
  }
  
  void winnerGame() {
      pushMatrix();
      camera();
      textSize(40);
      fill(255);
      text("YOU WIN", width/2, height/2);
      popMatrix();
  } 
  
  void showLevel() {
      pushMatrix();
      camera();
      textSize(40);
      fill(255);
      text(utils.getLevel(), width/2, 20);
      popMatrix();
  } 
}
