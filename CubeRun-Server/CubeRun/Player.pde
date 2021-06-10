public class Player {
  private DwSoftGrid3D player;
  private DwParticle.Param param_player_particle;
  private DwSpringConstraint.Param param_player_spring;

  //PARAMS
  private color colorPlayer;
  private PApplet exec;

  //POS
  private int xPos;
  private int yPos;
  private int zPos;

  //CAMERA
  private float focusX;
  private float focusZ;
  private float angle;

  public Player(PApplet exec, color colorPlayer) {
    this.player = new DwSoftGrid3D();
    this.param_player_particle = new DwParticle.Param();
    this.param_player_spring = new DwSpringConstraint.Param();
    init(); 

    //PARAMS
    this.exec = exec;
    this.colorPlayer = colorPlayer;
    setValues();
  } 

  public void setHeight(int val) {
    this.yPos = val;
  }

  public void resetHeight() {
    this.yPos = -180;
  }

  private void setValues() {
    //POS
    this.xPos = 0;
    this.yPos = -180;
    this.zPos = 0;

    //CAMERA
    this.focusX = 0;
    this.focusZ = 0;
    this.angle = 0;
  }

  private void init() {
    param_player_particle.DAMP_BOUNDS    = 0.89999f;
    param_player_particle.DAMP_COLLISION = 0.99999f;
    param_player_particle.DAMP_VELOCITY  = 0.99991f;   

    param_player_spring.damp_dec = 0.089999f;
    param_player_spring.damp_inc = 0.089999f;

    player.CREATE_STRUCT_SPRINGS = true;
    player.CREATE_SHEAR_SPRINGS  = true;
    player.CREATE_BEND_SPRINGS   = true;
    player.bend_spring_mode      = 0;
    player.bend_spring_dist      = 2;
  }

  public void createPlayer() {
    int nodes_x, nodes_y, nodes_z, nodes_r;

    this.player.self_collisions = true;
    this.player.collision_radius_scale = 1f;

    nodes_x = 4;
    nodes_y = 4;
    nodes_z = 4;
    nodes_r = 2;

    this.player.setMaterialColor(this.colorPlayer);
    this.player.setParticleColor(this.colorPlayer);
    this.player.setParam(param_player_particle);
    this.player.setParam(param_player_spring);
    this.player.create(physics.getPhysic(), nodes_x, nodes_y, nodes_z, nodes_r, this.xPos, this.yPos, this.zPos);
    this.player.createShapeParticles(this.exec, true);
  }

  public DwSoftBody3D getPlayer () {
    return this.player;
  }

  public void compute () {
    this.player.computeNormals();
  }

  public void display () {
    this.player.createShapeMesh(this.exec.g);
    this.player.displayMesh(this.exec.g);
  }

  public color getColor() {
    return this.colorPlayer;
  }

  public void setColor (color newColor) {
    this.player.setMaterialColor(newColor);
  }  

  public float[] getPos() {
    float minX = 10000;
    float minY = 10000; 
    float minZ = 10000;
    float maxX = -10000;
    float maxY = -10000; 
    float maxZ = -10000; 
    int i = 0;
    for (DwParticle3D pa : physics.getPhysic().getParticles()) {      
      if (pa.x() < minX) minX = pa.x();
      if (pa.y() < minY) minY = pa.y();
      if (pa.z() < minZ) minZ = pa.z();
      if (pa.x() > maxX) maxX = pa.x();
      if (pa.y() > maxY) maxY = pa.y();
      if (pa.z() > maxZ) maxZ = pa.z();
      if (i > 62) break;
      i++;
    }

    return new float[]{minX, maxX, minY, maxY, minZ, maxZ}; //Extremos del cubo jugador
  }  

  public float[] getMiddle () { //Centro del cubo
    float [] bounds = getPos();
    return new float[]{(bounds[0]+bounds[1])/2, 
      (bounds[2]+bounds[3])/2, 
      (bounds[4]+bounds[5])/2};
  }

  public void updateCamera() {
    float [] pos = getMiddle();  
    camera(getCloseFocus()[0], pos[1] + 60, getCloseFocus()[1], 
      getFarFocus()[0], -150, getFarFocus()[1], 
      0.02, -1.0, 0.0);

    /*camera(pos[0]-200, pos[1] + 80, pos[2] + 200,
     80000, -150, -100000,
     0.0, -0.5, 0.0);*/
  }

  void updateAngle(float newAngle) {
    this.angle += newAngle*1.5;    
    if (this.angle >= 360 || this.angle <= -360) this.angle = 0;
  }

  public float getAngle() {
    return this.angle;
  }

  public void reset() {
    init();
    setValues();
  }

  //------Cálculo del punto lejano para camera()---------//

  public float[] getFarFocus() {
    this.focusX = sin(radians(this.angle))*(width*1000000);
    this.focusZ = cos(radians(this.angle))*(-width*1000000);

    return new float[]{focusX, focusZ};
  }

  //------Cálculo del punto cercano en tercera persona para camera()---------//
  public float[] getCloseFocus() {
    float[] pos = getMiddle();
    float xpos = pos[0] + sin(radians(this.angle))*(-180);
    float zpos = pos[2] + cos(radians(this.angle))*(180);

    return new float[]{xpos, zpos};
  }

  public int [] getBoundsX() {
    float[] pos = getPos();
    return new int[]{int(pos[0]), int(pos[1])};
  }

  public int [] getBoundsY() {
    float[] pos = getPos();
    return new int[]{int(pos[2]), int(pos[3])};
  }

  public int [] getBoundsZ() {
    float[] pos = getPos();
    return new int[]{int(pos[4]), int(pos[5])};
  }
}
