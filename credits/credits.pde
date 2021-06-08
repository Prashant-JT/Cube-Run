import controlP5.*;
ControlP5 cp5;

PImage bg, icon, iconOver, goBackImg, goBackOverImg;
Boolean overLinkFab, overLinkJos, overLinkPra;

void setup() {
  size(600, 800);
  cp5 = new ControlP5(this);
  bg = loadImage("background.png");
  icon = loadImage("gitHubIcon.png");
  iconOver = loadImage("gitHubIconOver.png");
  goBackImg = loadImage("goBack.png");
  goBackOverImg = loadImage("goBackOver.png");
  cp5.addButton("linkFab").setValue(0).setPosition(110,250).setImage(icon).updateSize();
  cp5.addButton("linkJos").setValue(0).setPosition(430,450).setImage(icon).updateSize();
  cp5.addButton("linkPra").setValue(0).setPosition(110,650).setImage(icon).updateSize();
  cp5.addButton("goBackCredits").setValue(0).setPosition(20,20).setImage(goBackImg).updateSize();
}

void draw() {
  background(bg);
  textSize(50);
  textAlign(CENTER);
  text("Credits", 300, 135);
  textAlign(LEFT);
  textSize(20);
  text("Fabián Alfonso Beirutti Pérez", 210, 270);
  text("Fabbeiru", 210, 320);
  text("José María Amusquívar Poppe", 120, 470);
  text("JoseMAP-99", 120, 520);
  text("Prashant Jeswani Tejwani", 210, 670);
  text("Prashant-JT", 210, 720);
  mouseOverButtons();
}

void mouseOverButtons() {
  if (cp5.isMouseOver()) cursor(HAND);
  else cursor(ARROW);
  if (cp5.isMouseOver(cp5.getController("linkFab"))) {
    cp5.getController("linkFab").setImage(iconOver);
    overLinkFab = true;
  } else {
    cp5.getController("linkFab").setImage(icon);
    overLinkFab = false;
  }
  if (cp5.isMouseOver(cp5.getController("linkJos"))) {
    cp5.getController("linkJos").setImage(iconOver);
    overLinkJos = true;
  } else {
    cp5.getController("linkJos").setImage(icon);
    overLinkJos = false;
  }
  if (cp5.isMouseOver(cp5.getController("linkPra"))) {
    cp5.getController("linkPra").setImage(iconOver);
    overLinkPra = true;
  } else {
    cp5.getController("linkPra").setImage(icon);
    overLinkPra = false;
  }
  if (cp5.isMouseOver(cp5.getController("goBackCredits"))) {
    cp5.getController("goBackCredits").setImage(goBackOverImg);
  } else {
    cp5.getController("goBackCredits").setImage(goBackImg);
  }
}

void mousePressed() {
  if (overLinkFab) {
    link("https://github.com/Fabbeiru");
  }
  if (overLinkJos) {
    link("https://github.com/JoseMAP-99");
  }
  if (overLinkPra) {
    link("https://github.com/Prashant-JT");
  }
}
