import controlP5.ControlFont;
import ddf.minim.*;

class Intro {
  private PFont titleFont;
  private PImage background, musicImg, musicOverImg, noMusicImg, noMusicOverImg;
  private ControlP5 cp5;
  private AudioPlayer introSong;
  private Minim minim;
  private boolean noMusic, showCredits;
  private PApplet context;
  private Credits credits;

  public Intro (PApplet context) { 
    this.context = context;
    cp5 = new ControlP5(this.context);
    credits = new Credits(this.context);
    minim = new Minim(this.context);
    showCredits = false;
    loadMainMenu();
  }

  public void display () {
    mainMenu();
    mouseOverButtons();
    musicStatus();
    if (showCredits) credits.display();
  }

  void mainMenu() {
    background(background);
    textFont(titleFont);
    text("Cube", width/2 - 30, height/2 - 270);
    text("Run", width/2 + 50, height/2 - 190);
    if (noMusic) {
      cp5.getController("Music").hide();
      cp5.getController("noMusic").show();
    } else {
      cp5.getController("Music").show();
      cp5.getController("noMusic").hide();
    }
  }

  void loadMainMenu() {
    introSong = minim.loadFile("audio.mpeg");
    titleFont = createFont("FasterOne-Regular.ttf", 90);
    buttonTextFont = createFont("Nunito-Regular.ttf", 12);
    ControlFont font = new ControlFont(buttonTextFont, 241);
    background = loadImage("background.png");
    musicImg = loadImage("music.png");
    musicOverImg = loadImage("musicOver.png");
    noMusicImg = loadImage("noMusic.png");
    noMusicOverImg = loadImage("noMusicOver.png");
    noMusic = false;
    introSong.loop(10);
    PImage [] imgs = {loadImage("music.png"), loadImage("noMusic.png")};
    cp5.addButton("Play").setValue(0).setPosition(175, 300).setSize(250, 100).plugTo(this, "showPlay").getCaptionLabel().setFont(font).setSize(25);
    cp5.addButton("Settings").setValue(0).setPosition(175, 450).setSize(250, 100).getCaptionLabel().setFont(font).setSize(25);
    cp5.addButton("Credits").setValue(0).plugTo(this, "showCredits").setPosition(175, 600).setSize(250, 100).getCaptionLabel().setFont(font).setSize(25);
    cp5.addButton("Music").setValue(0).setPosition(520, 720).setImage(imgs[0]).updateSize().plugTo(this, "mute");
    cp5.addButton("noMusic").setValue(0).setPosition(520, 720).setImage(imgs[1]).updateSize().plugTo(this, "unmute");
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

  void showCredits() {
    this.cp5.hide();
    credits.showCP5();
    showCredits = !showCredits;
  }

  void showPlay() {
    this.cp5.hide();
    introShow = !introShow;
  }

  void setShowCredits() {
    showCredits = !showCredits;
    this.cp5.show();
  }

  public ControlP5 getCP5() {
    return this.cp5;
  }

  public AudioPlayer getIntroSong() {
    return this.introSong;
  }

  void setNoMusic() {
    this.noMusic = !this.noMusic;
  }

  void mute() {
    intro.getIntroSong().mute();
    intro.setNoMusic();
  }

  void unmute() {
    intro.getIntroSong().unmute();
    intro.setNoMusic();
  }
}
