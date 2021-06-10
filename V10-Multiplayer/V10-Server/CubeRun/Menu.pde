import controlP5.Accordion;
import controlP5.ControlP5;
import controlP5.Group;
import controlP5.Controller;
import controlP5.ColorWheel;

class Menu {
  private ControlP5 cp5;
  private PApplet context;
  private final int gui_w = 200;  
  private final int gui_y = 0;
  private int gui_x = width - gui_w;
  private PImage wKeyImg, aKeyImg, sKeyImg, dKeyImg, spacebarKeyImg, rKeyImg, pKeyImg;
  private int sx, sy, px, py, oy;

  public Menu (PApplet context) { 
    this.context = context;
    wKeyImg = loadImage("wKey.png");
    aKeyImg = loadImage("aKey.png");
    sKeyImg = loadImage("sKey.png");
    dKeyImg = loadImage("dKey.png");
    rKeyImg = loadImage("rKey.png");
    pKeyImg = loadImage("pKey.png");
    spacebarKeyImg = loadImage("spacebarKey.png");
    cp5 = new ControlP5(this.context);
    sx = 100; 
    sy = 14; 
    oy = (int)(sy*1.4f);
    init();
  }

  private void updateGuiW () {
    this.gui_x = width - gui_w;
    cp5.get(Accordion.class, "acc").setPosition(gui_x, gui_y);
    cp5.setGraphics(this.context, 0, 0);
  }

  private void init () {
    this.cp5.setAutoDraw(false);

    // Add both drop downs
    cp5.addAccordion("acc").setPosition(gui_x, gui_y).setSize(gui_w, 10)
      .setCollapseMode(Accordion.MULTI)
      .addItem(createGroupMenu())
      .addItem(createGroupControls());
  }

  private Group createGroupMenu() {
    // Menu drop down
    Group groupMenu = cp5.addGroup("menu");
    {
      Group group_options = groupMenu;
      group_options.setHeight(20).setSize(gui_w, 20).setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
      group_options.getCaptionLabel().align(CENTER, CENTER);

      px = 10; 
      py = 15;

      int bsx = (gui_w-40)/3;
      cp5.addButton("restart").setGroup(groupMenu)
        .plugTo(this, "restartGame")
        .setSize(bsx, 18)
        .setPosition(px, py);

      cp5.addButton("pause").setGroup(groupMenu)
        .plugTo(this, "pauseGame")
        .setSize(bsx, 18)
        .setPosition(px+=bsx+10, py);

      cp5.addButton("Go to menu").setGroup(groupMenu)
        .plugTo(this, "goToMenu")
        .setSize(bsx, 18)
        .setPosition(px+=bsx+10, py);

      cp5.addButton("help").setGroup(groupMenu)
        .plugTo(this, "showHelp")
        .setSize(bsx, 18)
        .setPosition(px-62, py+40);
    }  

    return groupMenu;
  }

  private Group createGroupControls () {
    // Controls drop down
    Group groupControls = cp5.addGroup("customize");
    {
      groupControls.setHeight(20).setSize(gui_w, 240).setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
      groupControls.getCaptionLabel().align(CENTER, CENTER);

      px = 10; 
      py = 15;

      cp5.addSlider("gravity").setGroup(groupControls)
        .setSize(sx, sy)
        .setPosition(px, py+=(int)(oy*1.5f))
        .setRange(0.35, 1)
        .setValue(physics.getGravity())
        .plugTo(this, "setGravity");

      cp5.addColorWheel("colorCube", px+35, py+=(int)(oy*2f), 100)
        .setGroup(groupControls)
        .setRGB(colorPlayer)
        .plugTo(this, "setColorCube");
    } 
    return groupControls;
  }

  void setColorCube() {
    color c = cp5.get(ColorWheel.class, "colorCube").getRGB();
    player.setColor(c);
    colorPlayer = c;
  }

  public void display () {
    if (this.gui_w + this.gui_x != width) updateGuiW();
    camera();
    if (showHelp) showHelpMessage();
    this.cp5.draw();
  }

  /**** CALLBACKS *****/
  void setGravity() {
    physics.updateGravity(cp5.getController("gravity").getValue());
  } 

  void pauseGame() {
    pauseGame = !pauseGame;
  }

  void restartGame() {
    utils.reset();  
    cp5.getController("gravity").setValue(physics.getGravity());
  }

  void goToMenu() {
    restartGame();
    introShow = true;
    intro.showCP5();
  }

  void showHelpMessage() {
    pushMatrix();
    translate(0, 0, -200);
    //background(120);
    stroke(255);
    strokeWeight(5);
    fill(25);
    textFont(buttonTextFont);
    rect(width/2 - 250, height/2 - 350, 500, 700, 10);
    image(wKeyImg, width/2 - 25, height/2 - 210);
    image(sKeyImg, width/2 - 25, height/2 - 150);
    image(aKeyImg, width/2 - 85, height/2 - 150);
    image(dKeyImg, width/2 + 35, height/2 - 150);
    image(spacebarKeyImg, width/2 - 100, height/2 + 20);
    image(rKeyImg, width/2 - 85, height/2 + 170);
    image(pKeyImg, width/2 + 35, height/2 + 170);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("Move", width/2 + 3, height/2 - 255);
    text("forward", width/2 + 3, height/2 - 230);
    text("Move", width/2 + 3, height/2 - 65);
    text("backward", width/2 + 1, height/2 - 40);
    textAlign(LEFT);
    text("Rotate", width/2 + 105, height/2 - 130);
    text("right", width/2 + 110, height/2 - 100);
    text("Rotate", width/2 - 165, height/2 - 130);
    text("left", width/2 - 150, height/2 - 100);
    textAlign(CENTER);
    text("Jump / Double jump", width/2 + 2, height/2 + 110);
    text("Restart", width/2 - 58, height/2 + 255);
    text("Pause", width/2 + 63, height/2 + 255);
    text("* Arrow keys also works to move player - camera", width/2, height/2 + 335);
    popMatrix();
    textFont(intro.getTitleFont());
  }

  void showHelp() {
    showHelp = !showHelp;
  }
}
