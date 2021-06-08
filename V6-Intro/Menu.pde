import controlP5.Accordion;
import controlP5.ControlP5;
import controlP5.Group;
import controlP5.Controller;

class Menu {
  private ControlP5 cp5;
  private PApplet context;
  private final int gui_w = 200;  
  private final int gui_y = 0;
  private int gui_x = width - gui_w;
  
  private int sx, sy, px, py, oy;

  public Menu (PApplet context) { 
    this.context = context;
    cp5 = new ControlP5(this.context);
    sx = 100; 
    sy = 14; 
    oy = (int)(sy*1.4f);
    init();
  }
  
  private void updateGuiW () {
    this.gui_x = width - gui_w;
    cp5.get(Accordion.class, "acc").setPosition(gui_x, gui_y);
    cp5.setGraphics(this.context,0,0);
  }

  private void init () {
    this.cp5.setAutoDraw(false);

    // Add both drop downs
    cp5.addAccordion("acc").setPosition(gui_x, gui_y).setSize(gui_w, 10)
      .setCollapseMode(Accordion.MULTI)
      .addItem(createGroupMenu())
      .addItem(createGroupControls());
  }

  private Group createGroupMenu () {
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

      cp5.addButton("exit").setGroup(groupMenu)
        .plugTo(this, "exitGame")
        .setSize(bsx, 18)
        .setPosition(px+=bsx+10, py);
    }  

    return groupMenu;
  }
  
  int test = 0;
  private Group createGroupControls () {
    // Controls drop down
    Group groupControls = cp5.addGroup("controls");
    {
      groupControls.setHeight(20).setSize(gui_w, 20).setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
      groupControls.getCaptionLabel().align(CENTER, CENTER);

      px = 10; 
      py = 15;

      cp5.addSlider("gravity").setGroup(groupControls)
        .setSize(sx, sy)
        .setPosition(px, py+=(int)(oy*1.5f))
        .setRange(0, 1)
        .setValue(physics.getGravity())
        .plugTo(this, "setGravity");

/**Esto no creo que haga falta
      cp5.addSlider("iter: springs").setGroup(groupControls)
        .setSize(sx, sy).setPosition(px, py+=oy)
        .setRange(0, 20)
        .setValue(test)
        .plugTo(test, "iterations_springs");

      cp5.addSlider("iter: collisions").setGroup(groupControls)
        .setSize(sx, sy)
        .setPosition(px, py+=oy)
        .setRange(0, 8)
        .setValue(test)
        .plugTo(test, "iterations_collisions");

      cp5.addRadio("setDisplayMode").setGroup(groupControls)
        .setSize(sy, sy).setPosition(px, py+=(int)(oy*1.4f))
        .setSpacingColumn(2).setSpacingRow(2).setItemsPerRow(1)
        .addItem("springs: colored", 0)
        .addItem("springs: tension", 1);
      //.activate(DISPLAY_MODE);
**/
    } 
    return groupControls;
  }
  
  public void display () {
    if (this.gui_w + this.gui_x != width) updateGuiW();
    camera();    
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
}
