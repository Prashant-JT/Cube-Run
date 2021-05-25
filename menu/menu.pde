import com.thomasdiewald.pixelflow.java.softbodydynamics.DwPhysics;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle3D;

import controlP5.Accordion;
import controlP5.ControlP5;
import controlP5.Group;

DwPhysics.Param param_physics = new DwPhysics.Param();
//physics simulation object
DwPhysics<DwParticle3D> physics = new DwPhysics<DwParticle3D>(param_physics);

// entities to display
boolean DISPLAY_PARTICLES      = false;
boolean DISPLAY_MESH           = true;
boolean DISPLAY_WIREFRAME      = false;
boolean DISPLAY_NORMALS        = false;
boolean DISPLAY_SRPINGS        = false;

int viewport_w = 1000;
int viewport_h = 600;

int gui_w = 200;
int gui_x = viewport_w - gui_w;
int gui_y = 0;

void setup() {
  size(1000, 600, P3D); 
  smooth(8);
  createMenu();
  frameRate(600);
}

void draw() {
  background(100);
  displayGUI();
}

// GUI
ControlP5 cp5;

public void displayGUI() {
  noLights();
  cp5.draw();
}


void createMenu() {
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  int sx, sy, px, py, oy;
  sx = 100; 
  sy = 14; 
  oy = (int)(sy*1.4f);

  // Menu drop down
  Group groupMenu = cp5.addGroup("menu");
  {
    Group group_cloth = groupMenu;
    group_cloth.setHeight(20).setSize(gui_w, 100).setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
    group_cloth.getCaptionLabel().align(CENTER, CENTER);

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

  // Controls drop down
  Group groupControls = cp5.addGroup("controls");
  {
    groupControls.setHeight(20).setSize(gui_w, height).setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
    groupControls.getCaptionLabel().align(CENTER, CENTER);

    px = 10; 
    py = 15;

    cp5.addSlider("gravity").setGroup(groupControls)
      .setSize(sx, sy)
      .setPosition(px, py+=(int)(oy*1.5f))
      .setRange(0, 1)
      .setValue(physics.param.GRAVITY[1])
      .plugTo(this, "setGravity");

    cp5.addSlider("iter: springs").setGroup(groupControls)
      .setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0, 20)
      .setValue(physics.param.iterations_springs)
      .plugTo( physics.param, "iterations_springs");

    cp5.addSlider("iter: collisions").setGroup(groupControls)
      .setSize(sx, sy)
      .setPosition(px, py+=oy)
      .setRange(0, 8)
      .setValue(physics.param.iterations_collisions)
      .plugTo( physics.param, "iterations_collisions");

    cp5.addRadio("setDisplayMode").setGroup(groupControls)
      .setSize(sy, sy).setPosition(px, py+=(int)(oy*1.4f))
      .setSpacingColumn(2).setSpacingRow(2).setItemsPerRow(1)
      .addItem("springs: colored", 0)
      .addItem("springs: tension", 1);
      //.activate(DISPLAY_MODE);

    cp5.addCheckBox("setDisplayTypes").setGroup(groupControls)
      .setSize(sy, sy).setPosition(px, py+=(int)(oy*2.4f))
      .setSpacingColumn(2).setSpacingRow(2).setItemsPerRow(1)
      .addItem("PARTICLES", 0).activate(DISPLAY_PARTICLES ? 0 : 5)
      .addItem("MESH ", 1).activate(DISPLAY_MESH ? 1 : 5)
      .addItem("SRPINGS", 2).activate(DISPLAY_SRPINGS ? 2 : 5)
      .addItem("NORMALS", 3).activate(DISPLAY_NORMALS ? 3 : 5)
      .addItem("WIREFRAME", 4).activate(DISPLAY_WIREFRAME ? 4 : 5);
  }

  // Add both drop downs
  cp5.addAccordion("acc").setPosition(gui_x, gui_y).setWidth(gui_w).setSize(gui_w, height)
    .setCollapseMode(Accordion.MULTI)
    .addItem(groupMenu)
    .addItem(groupControls)
    .open(0, 1, 2);
}
