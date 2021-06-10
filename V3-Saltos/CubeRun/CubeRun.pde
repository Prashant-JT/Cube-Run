/* Los obstáculos que son creados a raz de la pista funcionan mal con el salto de plataform*/
import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.softbodydynamics.DwPhysics;
import com.thomasdiewald.pixelflow.java.softbodydynamics.constraint.DwSpringConstraint;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftGrid3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.softbody.DwSoftBody3D;
import com.thomasdiewald.pixelflow.java.softbodydynamics.particle.DwParticle3D;
import com.thomasdiewald.pixelflow.java.utils.DwCoordinateTransform; //<>//

DwPixelFlow context;

Objects objects;
Obstacle obstacle; color colorObstacle = color(255, 228, 225);
Player player; color colorPlayer = color(52, 189, 225);
Scenario scenario; color backColor = color(68, 85, 90); color laneColor = color(209, 227, 209);
Physic physics;
Utils utils;
Collision collision;
    
void setup() {
  size(600, 800, P3D);  
  //surface.setLocation(230, 0); //Posición de la ventana
  
  context = new DwPixelFlow(this);
    
  utils = new Utils(this);
  scenario = new Scenario(backColor, laneColor);
  collision = new Collision();
  
  physics = new Physic();
  objects = new Objects();
  
  utils.initObjects();
}

void draw () { 
  scenario.displayBackground(); 
  
  player.updateCamera();   
  physics.updatePhysic();  
    
  player.compute();
  
  scenario.displayLane();
  scenario.setLights(); 
  
  for (Obstacle obs : objects.getList()) obs.display(); 
  
  player.display();
  
  collision.checkPlatform();
  
  moveShape(); 
}
