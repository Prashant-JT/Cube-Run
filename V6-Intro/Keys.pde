boolean [] keys = new boolean[7];
final int inc = 3;
final int jump = 10;
boolean jumping = false;
boolean pauseGame = false;

void moveShape() {  
  //if (keys[0] && !collision.check('l')) physics.updatePosX(inc, 0);  
  //if (keys[1] && !collision.check('r')) physics.updatePosX(-inc, 0);  
  if (keys[2] && !collision.check('f')) physics.updatePos(-inc, 0);
  if (keys[3] && !collision.check('b')) physics.updatePos(inc, 0);
  
  if (keys[0]) player.updateAngle(1);
  if (keys[1]) player.updateAngle(-1); //Antes era 6
    
  if (keys[4] && !collision.check('j')) {    
    player.setColor(color(random(255), random(255), random(255)));    
    physics.updatePos(0, jump);
  }
  
  if (!jumping &&
      !collision.check('r') && 
      !collision.check('l') &&
      !collision.check('f') &&
      !collision.check('b')) physics.resetLimits();
}

void setMovement(int k, boolean b) {
  switch (k) {      
      case 'A':
      case 'a':
        keys[0] = b;
        break;
      case 'D':
      case 'd':
        keys[1] = b;
        break;
      case 'W':
      case 'w':
        keys[2] = b;
        break;        
      case 'S':
      case 's':
        keys[3] = b;
        break;
      case ' ':
        keys[4] = b;
        break;
      case 'Q':
      case 'q':
        keys[5] = b;
        break;
      case 'E':
      case 'e':
        keys[6] = b;
        break;      
      case CODED:
        if (keyCode == LEFT){
          keys[0] = b;
        }else if(keyCode == RIGHT){
          keys[1] = b;
        }else if(keyCode == UP){
          keys[2] = b;
        }else if(keyCode == DOWN){
          keys[3] = b;
        }
    }
}

void keyReleased() {
  if (!pauseGame) setMovement(key, false);
}

void keyPressed() {
  if (!pauseGame) setMovement(key, true); 
  
  if (key == 'P' || key == 'p') pauseGame = !pauseGame;
  if (key == 'R' || key == 'r') menu.restartGame();
  
  if (key == 'C' || key == 'c') setPhoto.photoSetImage();
}
