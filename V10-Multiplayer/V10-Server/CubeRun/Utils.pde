public class Utils {    
  private PApplet exec;
  private ArrayList <int[]> params = new ArrayList<int[]>();
  private int level = 1;
  private int nObjects = 1;
  private int last = -175;
  private int newLast = -175+25;

  public Utils (PApplet exec) {
    this.exec = exec;  
    initPositions();
  }

  // -175 < - > 275 ---> Rango de X
  // -175 < - > 275 ---> Rango de Z
  // -175 < - > 275 ---> Rango de Y
  private void initPositions () {    
    for (int i = 0; i < this.nObjects; i++) {
      params.add(new int[] {r('w'), r('h'), r('w'), ra(), ra(), ra()});
    }
  }

  public int getLevel() {
    return this.level;
  }

  private int r(char which) {
    int value = (which == 'w') ? int(random(-175, 275)) : int(random(last, newLast));
    if (which == 'h') {
      last = newLast;
      newLast+=25;
    }
    return value;
  }

  private int ra() {
    return int(random(20, 50));
  }

  public void checkWinner() { 
    this.level++;
    this.nObjects+=10; 
    this.params.clear();
    last = -175;
    newLast = -175+25;
    this.initPositions();
    objects.resetList();
    reset();
  }

  void initObjects() {
    player = new Player(this.exec, colorPlayer);
    player.createPlayer(); 

    player2 = new Player(this.exec, colorPlayer);
    player2.createPlayer(); 

    for (int i = 0; i < this.nObjects-1; i++) {
      obstacle = new Obstacle(colorObstacle, this.params.get(i)); 
      objects.addBody(obstacle);
    }
    objects.addBody(new Obstacle(colorFinal, this.params.get(this.nObjects-1)));
  }

  void reset() {  
    physics = new Physic();    
    this.initObjects();
  }
}
