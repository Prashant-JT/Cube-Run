//import controlP5;

class Credits {
  ControlP5 cp5;
  private PApplet context;
  PImage bg, icon, iconOver, goBackImg, goBackOverImg;

  public Credits (PApplet context) { 
    this.context = context;
    cp5 = new ControlP5(this.context);
    bg = loadImage("background.png");
    icon = loadImage("gitHubIcon.png");
    iconOver = loadImage("gitHubIconOver.png");
    goBackImg = loadImage("goBack.png");
    goBackOverImg = loadImage("goBackOver.png");
    cp5.addButton("linkFab").setValue(0).setPosition(110, 250).setImage(icon).updateSize().plugTo(this, "goToFab");
    cp5.addButton("linkJos").setValue(0).setPosition(430, 450).setImage(icon).updateSize().plugTo(this, "goToJos");
    cp5.addButton("linkPra").setValue(0).setPosition(110, 650).setImage(icon).updateSize().plugTo(this, "goToPra");
    cp5.addButton("goBackCredits").setValue(0).setPosition(20, 20).setImage(goBackImg).updateSize().plugTo(this, "goBack");
    cp5.hide();
  }

  void display() {
    background(bg);
    textSize(50);
    textAlign(CENTER);
    text("Credits", 300, 135);
    textFont(buttonTextFont);
    textAlign(LEFT);
    textSize(20);
    text("Fabián Alfonso Beirutti Pérez", 210, 270);
    text("Fabbeiru", 210, 320);
    text("José María Amusquívar Poppe", 120, 470);
    text("JoseMAP-99", 120, 520);
    text("Prashant Jeswani Tejwani", 210, 670);
    text("Prashant-JT", 210, 720);
    textAlign(CENTER);
    mouseOverButtons();
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
