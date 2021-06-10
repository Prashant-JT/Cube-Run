public class Collision {
  private int[] boundsObjX, boundsObjY, boundsObjZ;
  private int[] boundsPlayX, boundsPlayY, boundsPlayZ;

  public Collision() {
  }

  public boolean check (char side) {    
    switch (side) {
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

  public void checkPlatform () {
    int[] boundsObjX, boundsObjY, boundsObjZ;
    boundsPlayX = player.getBoundsX();
    boundsPlayY = player.getBoundsY();
    boundsPlayZ = player.getBoundsZ();  
    for (Obstacle obs : objects.getList()) {
      boundsObjX = obs.getBoundsX();
      boundsObjY = obs.getBoundsY();
      boundsObjZ = obs.getBoundsZ();          
      if (((boundsPlayY[1]-8 >= boundsObjY[1] && boundsPlayY[1]-8 >= boundsObjY[0]) &&
        (boundsPlayY[0]-8 <= boundsObjY[0] && boundsPlayY[0]-8 >= boundsObjY[1])) &&
        ((boundsPlayX[0]+8 >= boundsObjX[1] && boundsPlayX[0]+8 <= boundsObjX[0]) ||
        (boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0])) && 
        ((boundsPlayZ[1]-8 >= boundsObjZ[1] && boundsPlayZ[1]-8 <= boundsObjZ[0]) &&
        (boundsPlayZ[0]+8 >= boundsObjZ[1] && boundsPlayZ[0]+8 <= boundsObjZ[0])))
      {
        if (obs.isLast()) {              
          sendData(0, 0, 0, 0, 1);
          text = "YOU WIN";
          utils.checkWinner();
          winner = true;
        }
        jumping = true;
        physics.updateDimensions(1, boundsObjY[0]-1);
        nJumps = 0;
        return;
      } else {
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
        physics.updateDimensions(2, boundsPlayZ[0]+4);
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

      if (((boundsPlayY[1]+8 >= boundsObjY[1] && boundsPlayY[1]+8 <= boundsObjY[0]) &&
        (boundsPlayY[0]+8 <= boundsObjY[1] && boundsPlayY[0]+8 <= boundsObjY[0])) &&
        ((boundsPlayX[0]+8 >= boundsObjX[1] && boundsPlayX[0]+8 <= boundsObjX[0]) ||
        (boundsPlayX[1]-8 >= boundsObjX[1] && boundsPlayX[1]-8 <= boundsObjX[0])) && 
        ((boundsPlayZ[1]-8 >= boundsObjZ[1] && boundsPlayZ[1]-8 <= boundsObjZ[0]) &&
        (boundsPlayZ[0]+8 >= boundsObjZ[1] && boundsPlayZ[0]+8 <= boundsObjZ[0])))
      {
        jumping = true;
        physics.updateDimensions(4, boundsObjY[1]-1);
        return true;
      } else {
        jumping = false;
      }
    }
    return false;
  }
}
