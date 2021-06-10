boolean [] keys = new boolean[4];
final int inc = 3;
final int jump = 15;
boolean jumping = false;
boolean pauseGame = false;
boolean winner = false;
int nJumps = 0;

void moveShape() {    
  if (keys[0]) {
    player.updateAngle(1);
    sendData(0, 0, 0, 1, 0);
  }
  if (keys[1]) {
    player.updateAngle(-1);
    sendData(0, 0, 0, -1, 0);
  }

  if (keys[2] && !collision.check('f')) {
    physics.updatePos(-inc, 0, -0.35);
    sendData(-inc, 0, -0.35, 0, 0);
  }
  if (keys[3] && !collision.check('b')) {
    physics.updatePos(inc, 0, -0.35);
    sendData(inc, 0, -0.35, 0, 0);
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
  case CODED:
    if (keyCode == LEFT) {
      keys[0] = b;
    } else if (keyCode == RIGHT) {
      keys[1] = b;
    } else if (keyCode == UP) {
      keys[2] = b;
    } else if (keyCode == DOWN) {
      keys[3] = b;
    }
  }
}

void keyReleased() {
  if (!pauseGame) setMovement(key, false);
}

void keyPressed() {
  if (winner) winner = false;
  if (!pauseGame) setMovement(key, true); 

  if (key == 'P' || key == 'p') pauseGame = !pauseGame;
  if (key == 'R' || key == 'r') menu.restartGame();

  if (key == 'C' || key == 'c') {
    setPhoto.photoSetImage();
    setPhoto.stopCamera();
    intro.showCP5();
  }

  if (key == ' ' && !pauseGame && !collision.check('j')) { 
    if (nJumps >= 2 && !(player.getBoundsY()[0]-5 <= -200)) return;
    if (player.getBoundsY()[0]-5 <= -200) nJumps = 0;
    nJumps++;
    thread("jumpSound");
    physics.updatePos(0, jump, -0.35);
    sendData(0, jump, -0.35, 0, 0);
  }
}

void jumpSound() {
  jumpSound.play();
}
