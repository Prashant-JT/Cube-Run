import com.thomasdiewald.pixelflow.java.DwPixelFlow; //<>//
import com.thomasdiewald.pixelflow.java.softbodydynamics.DwPhysics;
import com.thomasdiewald.pixelflow.java.softbodydynamics.constraint.DwSpringConstraint;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftGrid3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftBody3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle3D;
import com.thomasdiewald.pixelflow.java.utils.DwCoordinateTransform;
import processing.net.*;
import processing.sound.*;
import processing.serial.*;

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
SoundFile jumpSound;

PImage background; 
PFont buttonTextFont;
boolean introShow = true;
boolean showPhoto = false;
boolean showPlayer2 = false;
boolean showHelp = false;
int w, h;
String text = "YOU WIN";

Serial arduino;
String value;
boolean errorArduino = false;

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

  jumpSound = new SoundFile(this, "jump.wav");

  utils.initObjects();
  textAlign(CENTER, CENTER);  
  registerMethod("pre", this);

  s = new Server(this, XXXX);  // PUERTO 
  
  String[] portName = Serial.list();
  if (portName.length == 0) {
    println("There are no arduino available for playing");
    errorArduino = true;
  } else {
    println("Available serial devices:");
    for (int i = 0; i < portName.length; i++) println(portName[i]);
    arduino = new Serial(this, Serial.list()[0], 9600);
    arduino.bufferUntil('\n');
  }
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
    camera();
    intro.display();
  } else {     
    readData();
    scenario.displayBackground(); 

    menu.display();
    if (showHelp) return;

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

int centerX = 521;
int centerY = 511;
String val = "";
int jumpArd; 
void serialEvent(Serial arduino) {  
  if (!errorArduino && arduino.available() > 0) {
    val = arduino.readStringUntil('\n');
    
    if (val != null){
      val = trim(val);          
      int[] vals = int(splitTokens(val, ","));
      
      if (vals[2] == 1 && jumpArd == 0) {
        if (nJumps >= 2 && !(player.getBoundsY()[0]-5 <= -200)) return;
        if (player.getBoundsY()[0]-5 <= -200) nJumps = 0;
        nJumps++;
        thread("jumpSound");
        physics.updatePos(0, jump, -0.35);
        sendData(0, jump, -0.35, 0, 0);
        if (winner) winner = false;
      }
      jumpArd = vals[2];
          
      if (vals[1]+1 == centerY || vals[1] == centerY){
        keys[0] = false;
        keys[1] = false;        
      } else {
        if (winner) winner = false;
        if (vals[1]+1 > centerY) {
          keys[0] = true;
          keys[1] = false;
        } else {
          keys[0] = false;
          keys[1] = true;
        }
      }
      
      if (vals[0]+1 == centerX || vals[0] == centerX){
        keys[2] = false;
        keys[3] = false;
      } else {
        if (winner) winner = false;
        if (vals[0]+1 > centerX) {
          keys[2] = false;
          keys[3] = true;
        } else {
          keys[2] = true;
          keys[3] = false;
        }
      }
    }
  }
}
