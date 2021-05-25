boolean [] keys = new boolean[5];
final int axisX = 3;
final int axisZ = 3;
final int jump = 10;

void moveShape() {  
  if (keys[0] && !collision.check('l')) physics.updatePos(axisX, 0, 0);   
  if (keys[1] && !collision.check('r')) physics.updatePos(-axisX, 0, 0);   
  if (keys[2] && !collision.check('f')) physics.updatePos(0, -axisZ, 0);
  if (keys[3] && !collision.check('b')) physics.updatePos(0, axisZ, 0);
  
  if (keys[4] /*&& !collision.check('j')*/) {
    player.setColor(color(random(255), random(255), random(255)));    
    physics.updatePos(0, 0, jump);  
  }
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
  setMovement(key, false);
}

void keyPressed () {
  setMovement(key, true); 
}
