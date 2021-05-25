public class Utils {    
  private PApplet exec;
  private final ArrayList <int[]> params = new ArrayList<int[]>();
  private final int nObjects = 4;
  
  public Utils (PApplet exec) {
    this.exec = exec;  
    initPositions();
  }
  
  private void initPositions () {
    params.add(new int[] {0, -200, 0, 50, 50, 50});  // X, Y, Z, Width, Height, Depth
    params.add(new int[] {-100, -200, 100, 50, 50, 50});
    params.add(new int[] {100, -162, 150, 50, 50, 50}); //-162 EJE Y Tamaño del cubo (10x10x10)
    params.add(new int[] {100, -100, 0, 200, 40, 50});
  }
  
  /*
  void initObjects () {
    player = new Player(this.exec, colorPlayer);
    objects.addBody(player.getPlayer());
    player.createPlayer(); 
    
    // Inicialización de obstáculos
    for (int i = 0; i < 1; i++) {
      obstacle = new Obstacle(this.exec, colorObstacle, this.params.get(i)); 
      objects.addBody(obstacle.getObstacle());
      obstacle.createObstacle();
    } 
  }
  */
  
  void initObjects() {
    player = new Player(this.exec, colorPlayer);
    player.createPlayer(); 
    
    for (int i = 0; i < this.nObjects; i++) {
      obstacle = new Obstacle(colorObstacle, this.params.get(i)); 
      objects.addBody(obstacle);
    }
  }
  
  void reset() {
    objects.resetList();
    physics.resetPhysics();  
    player.createPlayer();
  }  
}
