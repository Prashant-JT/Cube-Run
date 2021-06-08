/* Los obstáculos que son creados a raz de la pista funcionan mal con el salto de plataform*/ //<>//
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.softbodydynamics.DwPhysics;
import com.thomasdiewald.pixelflow.java.softbodydynamics.constraint.DwSpringConstraint;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftGrid3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftBody3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle3D;
import com.thomasdiewald.pixelflow.java.utils.DwCoordinateTransform;

DwPixelFlow context;

Objects objects;
Obstacle obstacle; 
color colorObstacle = color(255, 228, 225);
Player player; 
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

PFont buttonTextFont;
boolean introShow = true;

void settings() {
  size(600, 800, P3D);  
  smooth(8);
}

void setup() {  
  //surface.setLocation(230, 0); //Posición de la ventana
  
  context = new DwPixelFlow(this);

  utils = new Utils(this);
  scenario = new Scenario(backColor, laneColor);
  collision = new Collision();

  physics = new Physic();
  objects = new Objects();
  menu = new Menu(this);
  intro = new Intro(this);
  views = new Views();

  utils.initObjects();

  textAlign(CENTER, CENTER);
}

void draw () {
  if (introShow) {
    intro.display();
    
  } else {
    scenario.displayBackground(); 

    menu.display();

    player.updateCamera();   
    physics.updatePhysic();  

    player.compute();

    scenario.displayLane();
    scenario.setLights(); 

    for (Obstacle obs : objects.getList()) obs.display(); 

    player.display();

    if (!pauseGame) {
      collision.checkPlatform();  
      moveShape();
    } else {
      views.pauseGame();
    }
  }
}
