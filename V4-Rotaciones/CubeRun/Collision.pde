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
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();  
    for (Obstacle obs : objects.getList()) {
       boundsObjX = obs.getBoundsX();
       boundsObjY = obs.getBoundsY();
       boundsObjZ = obs.getBoundsZ();
       if ((boundsPlayY[0]-7 <= boundsObjY[0] && boundsPlayY[0]-7 >= boundsObjY[1]) && 
           (boundsPlayY[1]+3 >= boundsObjY[1] && boundsPlayY[1]+3 >= boundsObjY[0])) {
          if (((boundsPlayX[0]+10 >= boundsObjX[1] && boundsPlayX[0]+10 <= boundsObjX[0]) ||
              (boundsPlayX[1]-10 >= boundsObjX[1] && boundsPlayX[1]-10 <= boundsObjX[0])) && 
             ((boundsPlayZ[1]-10 >= boundsObjZ[1] && boundsPlayZ[1]-10 <= boundsObjZ[0]) ||
              (boundsPlayZ[0]+10 >= boundsObjZ[1] && boundsPlayZ[0]+10 <= boundsObjZ[0])))
          {
            physics.updateDimensions(1, boundsPlayY[0]);
            jumping = true; 
          } 
        } else if (jumping){ 
            jumping = false;  
        }
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
       if ((boundsPlayX[1] >= boundsObjX[1] && boundsPlayX[1] <= boundsObjX[0]) && 
          ((boundsPlayZ[1]-8 >= boundsObjZ[1] && boundsPlayZ[1]-8 <= boundsObjZ[0]) ||
          (boundsPlayZ[0]+8 >= boundsObjZ[1] && boundsPlayZ[0]+8 <= boundsObjZ[0])) &&         
          ((boundsPlayY[1] >= boundsObjY[1] && boundsPlayY[1] <= boundsObjY[0])))          
          {
            physics.updateDimensions(3, boundsObjX[1]-4);
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
       if ((boundsPlayX[0] >= boundsObjX[1] && boundsPlayX[0] <= boundsObjX[0]) && 
          ((boundsPlayZ[1]-8 >= boundsObjZ[1] && boundsPlayZ[1]-8 <= boundsObjZ[0]) ||
          (boundsPlayZ[0]+8 >= boundsObjZ[1] && boundsPlayZ[0]+8 <= boundsObjZ[0])) && 
          ((boundsPlayY[1] >= boundsObjY[1] && boundsPlayY[1] <= boundsObjY[0])))     
          {
            physics.updateDimensions(0, boundsObjX[0]+4);
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
       if ((boundsPlayZ[0] <= boundsObjZ[0] && boundsPlayZ[0] >= boundsObjZ[1]) && 
          ((boundsPlayX[0]+8 >= boundsObjX[1] && boundsPlayX[0]+8 <= boundsObjX[0]) ||
          (boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0])) && 
          ((boundsPlayY[1] >= boundsObjY[1] && boundsPlayY[1] <= boundsObjY[0])))  
          {
            physics.updateDimensions(2, boundsObjZ[0]+4);
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
       if ((boundsPlayZ[1] >= boundsObjZ[1] && boundsPlayZ[1] <= boundsObjZ[0]) && 
          ((boundsPlayX[0]+8 >= boundsObjX[1] && boundsPlayX[0]+8 <= boundsObjX[0]) ||
          (boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0])) && 
          ((boundsPlayY[1] >= boundsObjY[1] && boundsPlayY[1] <= boundsObjY[0])))      
          {
            physics.updateDimensions(5, boundsObjZ[1]-4);
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
       if (((boundsPlayY[1] >= boundsObjY[1] && boundsPlayY[1] <= boundsObjY[0])) &&
          ((boundsPlayX[0]+8 >= boundsObjX[1] && boundsPlayX[0]+8 <= boundsObjX[0]) ||
           (boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0])) && 
          ((boundsPlayZ[1]-8 >= boundsObjZ[1] && boundsPlayZ[1]-8 <= boundsObjZ[0]) ||
           (boundsPlayZ[0]+8 >= boundsObjZ[1] && boundsPlayZ[0]+8 <= boundsObjZ[0])))
          {
            return true;
          } 
    }
    return false;
  } 
}
