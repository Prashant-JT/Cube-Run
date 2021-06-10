public class Utils {    
  private PApplet exec;
  private final ArrayList <int[]> params = new ArrayList<int[]>();
  private final int nObjects = 4;
  
  public Utils (PApplet exec) {
    this.exec = exec;  
    initPositions();
  }
  
  private void initPositions () {
    params.add(new int[] {-50, -170, -50, 50, 50, 50});  // X, Y, Z, Width, Height, Depth
    params.add(new int[] {50, -173, 100, 50, 50, 50}); //-173 es la base para cubo de 50
    params.add(new int[] {-100, -161, 150, 50, 50, 50}); //-161 EJE_Y más tamaño cubito -> límite 
    params.add(new int[] {150, -160, 0, 50, 50, 50});
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
