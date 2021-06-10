public class Collision {
  private int[] boundsObjX, boundsObjY, boundsObjZ;
  private int[] boundsPlayX, boundsPlayY, boundsPlayZ;
  
  public Collision() {}
  
  public boolean check (char side) {
    switch (side){
      case 'l':
        return collideLeft();
      case 'r':
        return collideRight();    
      case 'f':
        return collideFront();
      case 'b':
        return collideBack();
      case 'j':
        return collideJump();
    }
    return false;
  }
  
  public void checkPlatform (){
    int[] boundsObjX, boundsObjY, boundsObjZ;
    int i = 0;    
    for(DwParticle3D pa : physics.getPhysic().getParticles()){           
      for (Obstacle obs : objects.getList()) {
        boundsObjX = obs.getBoundsX();
        boundsObjY = obs.getBoundsY();
        boundsObjZ = obs.getBoundsZ(); 
        if (pa.y() >= boundsObjY[1]) {
          println("HAY ALGO" + i);
          physics.updateDimensions(1, pa.y());
        }
      }      
      if (i > 62) break;
      i++;
    }
  }  
  
  private boolean collideLeft () {
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();    
       if ((boundsPlayX[0]+14 >= boundsObjX[1] && boundsPlayX[1]+17 <= boundsObjX[0]) && 
          ((boundsPlayZ[0]+5 >= boundsObjZ[1] && boundsPlayZ[0]+5 <= boundsObjZ[0]) ||
          (boundsPlayZ[1]+15 >= boundsObjZ[1] && boundsPlayZ[1]+15 <= boundsObjZ[0])) &&
          (boundsPlayY[1]+obs.getSize() >= boundsObjY[0] && boundsPlayY[0]+obs.getSize() <= boundsObjY[1])) 
          {
            //physics.updateDimensions(3, boundsObjX[0]-26);
            return true;
          }
    }
    return false;
  }
    
  private boolean collideRight () {
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();    
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();       
       if ((boundsPlayX[1]-11 >= boundsObjX[1] && boundsPlayX[0]-11 <= boundsObjX[0]) && 
          ((boundsPlayZ[0]+5 >= boundsObjZ[1] && boundsPlayZ[0]+5 <= boundsObjZ[0]) ||
          (boundsPlayZ[1]+15 >= boundsObjZ[1] && boundsPlayZ[1]+15 <= boundsObjZ[0])) &&
          (boundsPlayY[1]+obs.getSize() >= boundsObjY[0] && boundsPlayY[0]+obs.getSize() <= boundsObjY[1]))  
          {
            //physics.updateDimensions(0, boundsObjX[0]-26);
            return true;
          }
    }  
    return false;
  } 
  
  private boolean collideFront () {
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();
       if ((boundsPlayZ[1]-12 >= boundsObjZ[1] && boundsPlayZ[0]-12 <= boundsObjZ[0]) && 
          ((boundsPlayX[0]+6 >= boundsObjX[1] && boundsPlayX[0]+6 <= boundsObjX[0]) ||
          (boundsPlayX[1]-11 >= boundsObjX[1] && boundsPlayX[1]+17 <= boundsObjX[0])) &&
          (boundsPlayY[1]+obs.getSize() >= boundsObjY[0] && boundsPlayY[0]+obs.getSize() <= boundsObjY[1]))  
          {
            //physics.updateDimensions(2, boundsObjZ[0]+26);
            return true;
          }    
    }
    return false;
  } 
  
  private boolean collideBack () {
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();
       if ((boundsPlayZ[0]+15 >= boundsObjZ[1] && boundsPlayZ[1]+15 <= boundsObjZ[0]) && 
          ((boundsPlayX[0]+6 >= boundsObjX[1] && boundsPlayX[0]+6 <= boundsObjX[0]) ||
          (boundsPlayX[1]-11 >= boundsObjX[1] && boundsPlayX[1]+17 <= boundsObjX[0])) &&
          (boundsPlayY[1]+obs.getSize()>= boundsObjY[0] && boundsPlayY[0]+obs.getSize() <= boundsObjY[1])) 
          {
            //physics.updateDimensions(5, boundsObjZ[0]+26);
            return true;
          } 
    }
    return false;
  } 
  
  private boolean collideJump () {
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();
       if ((boundsPlayZ[0]+15 >= boundsObjZ[1] && boundsPlayZ[1]+15 <= boundsObjZ[0]) && 
          ((boundsPlayX[0]+6 >= boundsObjX[1] && boundsPlayX[0]+6 <= boundsObjX[0]) ||
          (boundsPlayX[1]-11 >= boundsObjX[1] && boundsPlayX[1]+17 <= boundsObjX[0])) &&
          (boundsPlayY[1]+35 >= boundsObjY[0] && boundsPlayY[0]+35 <= boundsObjY[1])) 
          {
            //physics.updateDimensions(5, boundsObjZ[0]+26);
            return true;
          } 
    }
    return false;
  } 
}
