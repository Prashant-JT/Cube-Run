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
       if ((boundsPlayX[1] >= boundsObjX[1] && boundsPlayX[0] <= boundsObjX[1]) && 
          ((boundsPlayZ[1]+2 >= boundsObjZ[0] && boundsPlayZ[1]+2 <= boundsObjZ[1]) ||
          (boundsPlayZ[0]+8 >= boundsObjZ[0] && boundsPlayZ[0]+8 <= boundsObjZ[1])) &&           
          ((boundsPlayY[1]+4 >= boundsObjY[0] && boundsPlayY[1]+4 <= boundsObjY[1])))          
          {
            physics.updateDimensions(3, boundsObjX[0] - obs.getSize('x')-4);
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
       if ((boundsPlayX[1]-10 >= boundsObjX[0] && boundsPlayX[0]-10 <= boundsObjX[0]) && 
          ((boundsPlayZ[1]+2 >= boundsObjZ[0] && boundsPlayZ[1]+2 <= boundsObjZ[1]) ||
          (boundsPlayZ[0]+8 >= boundsObjZ[0] && boundsPlayZ[0]+8 <= boundsObjZ[1])) &&       
          ((boundsPlayY[1]+4 >= boundsObjY[0] && boundsPlayY[1]+4 <= boundsObjY[1])))     
          {
            physics.updateDimensions(0, boundsObjX[0] + obs.getSize('x')+4);
            return true;
          }
    }  
    return false;
  } 
  
  private boolean collideFront () {
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ(); 
    println("PLAYER");
    println(boundsPlayX);
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();       
       println(boundsObjX);
       println("------");
       if ((boundsPlayZ[1] >= boundsObjZ[1] && boundsPlayZ[0] <= boundsObjZ[1]) && 
          ((boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0]) ||
          (boundsPlayX[0]-2 >= boundsObjX[1] && boundsPlayX[0]-2 <= boundsObjX[0])) &&
          ((boundsPlayY[1]+4 >= boundsObjY[0] && boundsPlayY[1]+4 <= boundsObjY[1]))) 
          {
            physics.updateDimensions(2, boundsObjZ[0] + obs.getSize('z')+4);
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
       if ((boundsPlayZ[1]+10 >= boundsObjZ[0] && boundsPlayZ[0]+10 <= boundsObjZ[0]) && 
          ((boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0]) ||
          (boundsPlayX[0]-2 >= boundsObjX[1] && boundsPlayX[0]-2 <= boundsObjX[0])) &&
          ((boundsPlayY[1]+4 >= boundsObjY[0] && boundsPlayY[1]+4 <= boundsObjY[1])))     
          {
            physics.updateDimensions(5, boundsObjZ[0] - obs.getSize('z')-4);
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
       if ((boundsPlayY[1]+4 >= boundsObjY[0] && boundsPlayY[1]+4 <= boundsObjY[1]) &&
          ((boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0]) ||
           (boundsPlayX[0]-2 >= boundsObjX[1] && boundsPlayX[0]-2 <= boundsObjX[0])) &&
          ((boundsPlayZ[1]+2 >= boundsObjZ[0] && boundsPlayZ[1]+2 <= boundsObjZ[1]) ||
           (boundsPlayZ[0]+8 >= boundsObjZ[0] && boundsPlayZ[0]+8 <= boundsObjZ[1])))
          {
            return true;
          } 
    }
    return false;
  } 
}
