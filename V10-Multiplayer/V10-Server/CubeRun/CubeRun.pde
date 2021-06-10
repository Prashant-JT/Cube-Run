import com.thomasdiewald.pixelflow.java.DwPixelFlow; //<>//
import com.thomasdiewald.pixelflow.java.softbodydynamics.DwPhysics;
import com.thomasdiewald.pixelflow.java.softbodydynamics.constraint.DwSpringConstraint;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftGrid3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftBody3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle3D;
import com.thomasdiewald.pixelflow.java.utils.DwCoordinateTransform;
import processing.net.*;

Server s; 
Client c;
String input;
float data[];

DwPixelFlow context;

Objects objects;
Obstacle obstacle; 
color colorObstacle = color(255, 228, 225);
color colorFinal = color(178, 34, 34);
Player player; 
Player player2;
color colorPlayer = color(52, 189, 225);
Scenario scenario; 
color backColor = color(68, 85, 90); 
color laneColor = color(41, 41, 41);
Physic physics;
Utils utils;
Collision collision;
Menu menu;
Views views;
Intro intro;
Photo setPhoto;

PImage background; 
PFont buttonTextFont;
boolean introShow = true;
boolean showPhoto = false;
boolean showPlayer2 = false;
int w, h;
String text = "YOU WIN";

void settings() {
  size(600, 800, P3D);  
  smooth(8);
}

void setup() {    
  background = loadImage("background.png");
  context = new DwPixelFlow(this);

  utils = new Utils(this);
  scenario = new Scenario(backColor, laneColor);
  collision = new Collision();

  physics = new Physic();
  objects = new Objects();
  menu = new Menu(this);
  intro = new Intro(this);
  views = new Views();
  setPhoto = new Photo(this);

  utils.initObjects();
  textAlign(CENTER, CENTER);  
  registerMethod("pre", this);
  
  s = new Server(this, 5000);  // Start a simple server on a port
}

void pre() {
  if (w != width || h != height) {
    w = width;
    h = height;
    background.resize(w, h);
    intro.updateGuiW();
  }
}

void draw () {
  fill(255);
  background(background);
  if (introShow) { 
    player.updateCamera();   
    physics.updatePhysic(); 
    player.compute();
    scenario.setLights(); 
    player.display();    
    camera();
    intro.display();
  } else {     
    readData();
    scenario.displayBackground(); 
    
    menu.display();

    player.updateCamera();   
    physics.updatePhysic();  

    player.compute();
    if (showPlayer2) player2.compute();

    scenario.displayLane();
    scenario.setLights(); 

    for (Obstacle obs : objects.getList()) obs.display(); 

    player.display();
    if (showPlayer2) player2.display();

    if (!pauseGame) {
      collision.checkPlatform();  
      moveShape();
    } else {
      views.pauseGame();
    }  
    
    if (winner) views.messageGame();
    views.showLevel();
  }
  if (showPhoto) setPhoto.display();
}

void readData() {
  // Receive data from server
  c = s.available();
  if (c != null) { 
    input = c.readString(); 
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = float(split(input, ' '));  // Split values into an array
    //println(data[0], data[1], data[2]);
    if (data.length >= 5) {
      if (data[4] != 0) {
        text = "YOU LOSE";
        winner = true;
        utils.checkWinner();
      }
      if (data[3] != 0) player2.updateAngle(data[3]);
      if (data[2] != 0) physics.updatePosOpponent(data[0], data[1], data[2]);
      showPlayer2 = true;
    } else {
      showPlayer2 = false;
    }
  }
}

void sendData(float inc, float jump, float grav, int angle, int level) {
  s.write(inc + " " + jump + " " + grav + " " + angle + " " + level + "\n");
}
