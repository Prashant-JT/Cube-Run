import java.util.ArrayList;
import java.util.Locale;

import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.imageprocessing.filter.DwFilter;
import com.thomasdiewald.pixelflow.java.softbodydynamics.DwPhysics;
import com.thomasdiewald.pixelflow.java.softbodydynamics.constraint.DwSpringConstraint;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftBall3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftBody3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftGrid3D;
import com.thomasdiewald.pixelflow.java.utils.DwCoordinateTransform;
import com.thomasdiewald.pixelflow.java.utils.DwStrokeStyle;

import controlP5.Accordion;
import controlP5.ControlP5;
import controlP5.Group;
import peasy.CameraState;
import peasy.PeasyCam;
import processing.core.PApplet;
import processing.core.PFont;
import processing.core.PShape;
import processing.opengl.PGraphics2D;
import processing.opengl.PGraphics3D;

// main library context
DwPixelFlow context;

DwPhysics.Param param_physics = new DwPhysics.Param();

// // physics simulation object
DwPhysics<DwParticle3D> physics = new DwPhysics<DwParticle3D>(param_physics);

// cloth objects
DwSoftGrid3D cloth = new DwSoftGrid3D();
DwSoftGrid3D cube1 = new DwSoftGrid3D();
DwSoftGrid3D cube2 = new DwSoftGrid3D();
DwSoftBall3D ball  = new DwSoftBall3D();

// list, that wills store the softbody objects (cloths, cubes, balls, ...)
ArrayList<DwSoftBody3D> softbodies = new ArrayList<DwSoftBody3D>();

// particle parameters
DwParticle.Param param_cloth_particle = new DwParticle.Param();
DwParticle.Param param_cube_particle  = new DwParticle.Param();
DwParticle.Param param_ball_particle  = new DwParticle.Param();

// spring parameters
DwSpringConstraint.Param param_cloth_spring = new DwSpringConstraint.Param();
DwSpringConstraint.Param param_cube_spring  = new DwSpringConstraint.Param();
DwSpringConstraint.Param param_ball_spring  = new DwSpringConstraint.Param();


// camera
PeasyCam peasycam;
CameraState cam_state_0;

// cloth texture
PGraphics2D texture;

// global states
int BACKGROUND_COLOR = 92;

// 0 ... default: particles, spring
// 1 ... tension
int DISPLAY_MODE = 0;

// entities to display
boolean DISPLAY_PARTICLES      = false;
boolean DISPLAY_MESH           = true;
boolean DISPLAY_WIREFRAME      = false;
boolean DISPLAY_NORMALS        = false;
boolean DISPLAY_SRPINGS        = false;

boolean DISPLAY_SPRINGS_STRUCT = true;
boolean DISPLAY_SPRINGS_SHEAR  = true;
boolean DISPLAY_SPRINGS_BEND   = true;

boolean UPDATE_PHYSICS         = true;

// first thing to do, inside draw()
boolean NEED_REBUILD = false;

int viewport_w = 1000;
int viewport_h = 600;
int viewport_x = 230;
int viewport_y = 0;

int gui_w = 200;
int gui_x = viewport_w - gui_w;
int gui_y = 0;

public void settings() {
  size(viewport_w, viewport_h, P3D); 
  smooth(8);
}


public void setup() {
  surface.setLocation(1024, 720);

  // gui
  createGUI();

  frameRate(600);
}


//////////////////////////////////////////////////////////////////////////////
// draw()
//////////////////////////////////////////////////////////////////////////////

public void draw() {
  background(100);
  displayGUI();
}

boolean APPLY_WIND     = false;
boolean MOVE_CAM       = false;
boolean MOVE_PARTICLE  = false;
boolean SNAP_PARTICLE  = false;
float   SNAP_RADIUS    = 30;
boolean DELETE_SPRINGS = false;
float   DELETE_RADIUS  = 15;

public void mousePressed() {
  if ((mouseButton == LEFT || mouseButton == CENTER) && !MOVE_CAM) {
    MOVE_PARTICLE = true;
  }
  if (mouseButton == RIGHT && !MOVE_CAM) {
    DELETE_SPRINGS = true;
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == ALT) {
      MOVE_CAM = true;
    }
  }
}

////////////////////////////////////////////////////////////////////////////
// GUI
////////////////////////////////////////////////////////////////////////////



ControlP5 cp5;

public void displayGUI() {
  noLights();
  cp5.draw();
}


public void createGUI() {
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  int sx, sy, px, py, oy;
  sx = 100; 
  sy = 14; 
  oy = (int)(sy*1.4f);

  // GUI - Menu
  Group group_springs = cp5.addGroup("menu");
  {
    Group group_cloth = group_springs;

    group_cloth.setHeight(20).setSize(gui_w, 210)
      .setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
    group_cloth.getCaptionLabel().align(CENTER, CENTER);

    px = 10; 
    py = 15;

    cp5.addSlider("Cloth.tensile").setGroup(group_cloth).setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0.01f, 1).setValue(param_cloth_spring.damp_dec).plugTo(param_cloth_spring, "damp_dec");

    cp5.addSlider("Cloth.pressure").setGroup(group_cloth).setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0.01f, 1).setValue(param_cloth_spring.damp_inc).plugTo(param_cloth_spring, "damp_inc");

    cp5.addSlider("Cube.tensile").setGroup(group_cloth).setSize(sx, sy).setPosition(px, py+=(int)(oy*2))
      .setRange(0.01f, 1).setValue(param_cube_spring.damp_dec).plugTo(param_cube_spring, "damp_dec");

    cp5.addSlider("Cube.pressure").setGroup(group_cloth).setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0.01f, 1).setValue(param_cube_spring.damp_inc).plugTo(param_cube_spring, "damp_inc");

    cp5.addSlider("Ball.tensile").setGroup(group_cloth).setSize(sx, sy).setPosition(px, py+=(int)(oy*2))
      .setRange(0.01f, 1).setValue(param_ball_spring.damp_dec).plugTo(param_ball_spring, "damp_dec");

    cp5.addSlider("Ball.pressure").setGroup(group_cloth).setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0.01f, 1).setValue(param_ball_spring.damp_inc).plugTo(param_ball_spring, "damp_inc");
  }
  
  // GUI - Controls
  Group group_physics = cp5.addGroup("controls");
  {
    group_physics.setHeight(20).setSize(gui_w, height)
      .setBackgroundColor(color(0, 204)).setColorBackground(color(0, 204));
    group_physics.getCaptionLabel().align(CENTER, CENTER);

    px = 10; 
    py = 15;

    int bsx = (gui_w-40)/3;
    cp5.addButton("restart").setGroup(group_physics).plugTo(this, "createBodies").setSize(bsx, 18).setPosition(px, py);
    cp5.addButton("pause")  .setGroup(group_physics).plugTo(this, "togglePause").setSize(bsx, 18).setPosition(px+=bsx+10, py);
    cp5.addButton("exit")   .setGroup(group_physics).plugTo(this, "resetCam").setSize(bsx, 18).setPosition(px+=bsx+10, py);

    px = 10; 
    cp5.addSlider("gravity").setGroup(group_physics).setSize(sx, sy).setPosition(px, py+=(int)(oy*1.5f))
      .setRange(0, 1).setValue(physics.param.GRAVITY[1]).plugTo(this, "setGravity");

    cp5.addSlider("iter: springs").setGroup(group_physics).setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0, 20).setValue(physics.param.iterations_springs).plugTo( physics.param, "iterations_springs");

    cp5.addSlider("iter: collisions").setGroup(group_physics).setSize(sx, sy).setPosition(px, py+=oy)
      .setRange(0, 8).setValue(physics.param.iterations_collisions).plugTo( physics.param, "iterations_collisions");

    cp5.addRadio("setDisplayMode").setGroup(group_physics).setSize(sy, sy).setPosition(px, py+=(int)(oy*1.4f))
      .setSpacingColumn(2).setSpacingRow(2).setItemsPerRow(1)
      .addItem("springs: colored", 0)
      .addItem("springs: tension", 1);
    //.activate(DISPLAY_MODE);

    cp5.addCheckBox("setDisplayTypes").setGroup(group_physics).setSize(sy, sy).setPosition(px, py+=(int)(oy*2.4f))
      .setSpacingColumn(2).setSpacingRow(2).setItemsPerRow(1)
      .addItem("PARTICLES", 0).activate(DISPLAY_PARTICLES ? 0 : 5)
      .addItem("MESH ", 1).activate(DISPLAY_MESH      ? 1 : 5)
      .addItem("SRPINGS", 2).activate(DISPLAY_SRPINGS   ? 2 : 5)
      .addItem("NORMALS", 3).activate(DISPLAY_NORMALS   ? 3 : 5)
      .addItem("WIREFRAME", 4).activate(DISPLAY_WIREFRAME ? 4 : 5);
  }

  ////////////////////////////////////////////////////////////////////////////
  // GUI - ACCORDION
  ////////////////////////////////////////////////////////////////////////////
  cp5.addAccordion("acc").setPosition(gui_x, gui_y).setWidth(gui_w).setSize(gui_w, height)
    .setCollapseMode(Accordion.MULTI)
    .addItem(group_springs)
    .addItem(group_physics)
    .open(0, 1, 2);
}
