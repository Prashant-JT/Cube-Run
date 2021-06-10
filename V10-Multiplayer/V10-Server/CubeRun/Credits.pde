class Credits {
  ControlP5 cp5;
  private PApplet context;
  PImage icon, iconOver, goBackImg, goBackOverImg;

  public Credits (PApplet context) { 
    this.context = context;
    cp5 = new ControlP5(this.context);
    icon = loadImage("gitHubIcon.png");
    iconOver = loadImage("gitHubIconOver.png");
    goBackImg = loadImage("goBack.png");
    goBackOverImg = loadImage("goBackOver.png");
    cp5.addButton("linkFab").setPosition((width/2 - 190), (height/2 - 150)).setImage(icon).updateSize().plugTo(this, "goToFab");
    cp5.addButton("linkJos").setPosition((width/2 - 190)+320, (height/2 - 150)+200).setImage(icon).updateSize().plugTo(this, "goToJos");
    cp5.addButton("linkPra").setPosition((width/2 - 190), (height/2 - 150)+400).setImage(icon).updateSize().plugTo(this, "goToPra");
    cp5.addButton("goBackCredits").setPosition(20, 20).setImage(goBackImg).updateSize().plugTo(this, "goBack");
    cp5.hide();
  }

  void display() {
    textSize(50);
    textAlign(CENTER);
    text("Credits", width/2, height/2 - 270);
    textFont(buttonTextFont);
    textAlign(LEFT);
    textSize(20);
    text("Fabián Alfonso Beirutti Pérez", (width/2 - 190)+100, (height/2 - 150)+20);
    text("Fabbeiru", (width/2 - 190)+100, (height/2 - 150)+70);
    text("José María Amusquívar Poppe", (width/2 - 190)+10, (height/2 - 150)+220);
    text("JoseMAP-99", (width/2 - 190)+10, (height/2 - 150)+270);
    text("Prashant Jeswani Tejwani", (width/2 - 190)+100, (height/2 - 150)+420);
    text("Prashant-JT", (width/2 - 190)+100, (height/2 - 150)+470);
    textAlign(CENTER);
    mouseOverButtons();
  }

  public void updateGuiW () {
    cp5.getController("linkFab").setPosition((width/2 - 190), (height/2 - 150));
    cp5.getController("linkJos").setPosition((width/2 - 190)+320, (height/2 - 150)+200);
    cp5.getController("linkPra").setPosition((width/2 - 190), (height/2 - 150)+400);
    cp5.setGraphics(this.context, 0, 0);
  }

  void mouseOverButtons() {
    if (cp5.isMouseOver()) cursor(HAND);
    else cursor(ARROW);
    if (cp5.isMouseOver(cp5.getController("linkFab"))) {
      cp5.getController("linkFab").setImage(iconOver);
    } else {
      cp5.getController("linkFab").setImage(icon);
    }
    if (cp5.isMouseOver(cp5.getController("linkJos"))) {
      cp5.getController("linkJos").setImage(iconOver);
    } else {
      cp5.getController("linkJos").setImage(icon);
    }
    if (cp5.isMouseOver(cp5.getController("linkPra"))) {
      cp5.getController("linkPra").setImage(iconOver);
    } else {
      cp5.getController("linkPra").setImage(icon);
    }
    if (cp5.isMouseOver(cp5.getController("goBackCredits"))) {
      cp5.getController("goBackCredits").setImage(goBackOverImg);
    } else {
      cp5.getController("goBackCredits").setImage(goBackImg);
    }
  }

  void goBack() {
    this.cp5.hide();
    cursor(ARROW);
    intro.setShowCredits();
  }

  void showCP5() {
    this.cp5.show();
  }

  void goToFab() {
    link("https://github.com/Fabbeiru");
  }

  void goToJos() {
    link("https://github.com/JoseMAP-99");
  }

  void goToPra() {
    link("https://github.com/Prashant-JT");
  }
}
