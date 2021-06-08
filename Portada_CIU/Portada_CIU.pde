import controlP5.*;
import ddf.minim.*;

PFont titleFont, buttonTextFont;
PImage background, musicImg, musicOverImg, noMusicImg, noMusicOverImg;
ControlP5 cp5;
AudioPlayer introSong;
Minim minim;
Boolean introSongStatus, noMusic;

int loopcount;

void setup() {
  size(600, 800);
  loadMainMenu();
}

void draw () {
  mainMenu();
  mouseOverButtons();
  musicStatus();
}

void mainMenu() {
  background(background);
  textFont(titleFont);
  text("Cube", 150, 150);
  text("Run", 250, 230);
  if (noMusic) {
    cp5.getController("Music").hide();
    cp5.getController("noMusic").show();
  } else {
    cp5.getController("Music").show();
    cp5.getController("noMusic").hide();
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
  musicImg = loadImage("music.png");
  musicOverImg = loadImage("musicOver.png");
  noMusicImg = loadImage("noMusic.png");
  noMusicOverImg = loadImage("noMusicOver.png");
  introSongStatus = true;
  noMusic = false;
  introSong.loop(10);
  PImage [] imgs = {loadImage("music.png"), loadImage("noMusic.png")};
  cp5.addButton("Play").setValue(0).setPosition(175,300).setSize(250,100).getCaptionLabel().setFont(font).setSize(25);
  cp5.addButton("Settings").setValue(0).setPosition(175,450).setSize(250,100).getCaptionLabel().setFont(font).setSize(25);
  cp5.addButton("Credits").setValue(0).setPosition(175,600).setSize(250,100).getCaptionLabel().setFont(font).setSize(25);
  cp5.addButton("Music").setValue(0).setPosition(520,720).setImage(imgs[0]).updateSize();
  cp5.addButton("noMusic").setValue(0).setPosition(520,720).setImage(imgs[1]).updateSize();
}

void musicStatus() {
  if (!introSong.isPlaying()) {
    introSong.play();
  }
}

void mouseOverButtons() {
  if (cp5.isMouseOver(cp5.getController("Music"))) {
    cp5.getController("Music").setImage(musicOverImg);
  } else {
    cp5.getController("Music").setImage(musicImg);
  }
  if (cp5.isMouseOver(cp5.getController("noMusic"))) {
    cp5.getController("noMusic").setImage(noMusicOverImg);
  } else {
    cp5.getController("noMusic").setImage(noMusicImg);
  }
}

void mousePressed() {
  if (cp5.isMouseOver(cp5.getController("Music"))) {
    introSong.mute();
    noMusic = true;
  } 
  if (cp5.isMouseOver(cp5.getController("noMusic"))) {
    introSong.unmute();
    noMusic = false;
  }
}
