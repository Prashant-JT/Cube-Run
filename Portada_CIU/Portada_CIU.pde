import controlP5.*;
import ddf.minim.*;

PFont titleFont, buttonTextFont;
PImage background, img2, img4;
ControlP5 cp5;
AudioPlayer introSong;
Minim minim;
Boolean introSongStatus;

void setup() {
  size(600, 800);
  loadMainMenu();
}

void draw () {
  background(background);
  textFont(titleFont);
  text("Cube", 150, 150);
  text("Run", 250, 230);
  if (!introSongStatus) {
    introSong.play();
    introSongStatus = true;
  }
  if (introSong.isMuted()) {
    cp5.getController("Sound").hide();
    cp5.getController("noSound").show();
  } else {
    cp5.getController("Sound").show();
    cp5.getController("noSound").hide();
  }
  if (cp5.isMouseOver(cp5.getController("Sound"))) {
    cp5.getController("Sound").setImage(img4);
  } else {
    cp5.getController("Sound").setImage(img2);
  }
}

void loadMainMenu() {
  minim = new Minim(this);
  cp5 = new ControlP5(this);
  introSong = minim.loadFile("audio.mpeg");
  titleFont = createFont("FasterOne-Regular.ttf", 90);
  buttonTextFont = createFont("Nunito-Regular.ttf", 12);
  ControlFont font = new ControlFont(buttonTextFont, 241);
  background = loadImage("background.png");
  img4 = loadImage("musicOver.png");
  img2 = loadImage("music.png");
  introSongStatus = false;
  PImage [] imgs = {loadImage("music.png"), loadImage("noMusic.png"), loadImage("sounds.png"), loadImage("noSounds.png")};
  cp5.addButton("Start").setValue(0).setPosition(175,300).setSize(250,100).getCaptionLabel().setFont(font).setSize(25);
  cp5.addButton("Settings").setValue(0).setPosition(175,450).setSize(250,100).getCaptionLabel().setFont(font).setSize(25);
  cp5.addButton("Credits").setValue(0).setPosition(175,600).setSize(250,100).getCaptionLabel().setFont(font).setSize(25);
  cp5.addButton("Sound").setValue(0).setPosition(520,720).setImage(imgs[0]).updateSize();
  cp5.addButton("noSound").setValue(0).setPosition(520,720).setImage(imgs[1]).updateSize();
}

public void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getName());
}

void mousePressed() {
  for (ControllerInterface c : cp5.getMouseOverList()) {
    if(c.getName() == "Sound") {
      introSong.mute();
    }
  }
}
