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

  void messageGame() {
    pushMatrix();
    camera();
    textSize(40);
    fill(255);
    text(text, width/2, height/2);
    popMatrix();
  } 

  void showLevel() {
    pushMatrix();
    camera();
    textSize(40);
    fill(255);
    text(utils.getLevel(), width/2, 30);
    popMatrix();
  }
}
