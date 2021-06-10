public class Physic {
  
  private DwPhysics.Param param_physics;
  private DwPhysics<DwParticle3D> physics;
  private float [] gravity;
  private float [] dimensions;
  
  public Physic(float [] gravity, float [] dimensions) {
    this.param_physics = new DwPhysics.Param();
    this.physics = new DwPhysics<DwParticle3D>(this.param_physics);    
    
    //PARAMS
    this.gravity = gravity;
    this.dimensions = dimensions;
    init();
  }
    
  public Physic() {
    this(new float[]{0, -0.35, 0}, new float[]{-200, -200, -Float.MAX_VALUE, 200, 100, 300}); 
  }
  
  private void init() {
    param_physics.GRAVITY = this.gravity;    // {x, y, z}
    param_physics.bounds  = this.dimensions; // {xmin, ymin, zmin, xmax, ymax, zmax} 
    param_physics.iterations_collisions = 2;
    param_physics.iterations_springs    = 8;     
  }
  
  public void updateDimensions (int indx, float value) {
    resetDimensions();
    this.dimensions[indx] = value;
    param_physics.bounds = this.dimensions;
  }
  
  private void resetDimensions () {
    this.dimensions = new float[]{-200, -200, -Float.MAX_VALUE, 200, 100, 300};   
  }
  
  public void resetLimits () {
    resetDimensions();
    param_physics.bounds = this.dimensions;
  }
  
  public DwPhysics.Param getParam () {
    return this.param_physics;
  }
    
  public void setGravity(float [] newGravity) {
    this.gravity = newGravity;  
  }
  
  public void resetPhysics() {
    this.physics.reset();  
  }
  
  public void updatePhysic() {
    this.physics.update(1);
  }
  
  public DwPhysics<DwParticle3D> getPhysic() {
    return this.physics;  
  }
  
  public void updatePos(float inc, float jump){
    float[] moves = new float[3]; 
    int i = 0;    
    for(DwParticle3D pa : this.physics.getParticles()){
      moves[0] = pa.x() + sin(radians(player.getAngle()))*(-inc*1.5);
      moves[1] = pa.y() + jump;
      moves[2] = pa.z() + cos(radians(player.getAngle()))*(inc*1.5);
      
      pa.moveTo(moves, 0.35f);
      //pa.addForce(new float[]{0, -1.8, 0});
      pa.addGravity(new float[]{0, -0.8, 0});
      
      if (i > 62) break;
      i++;
    }
  }   
  
  public void updatePosX(float inc, float jump){
    float[] moves = new float[3]; 
    int i = 0;    
    for(DwParticle3D pa : this.physics.getParticles()){
      moves[0] = pa.x() + sin(radians(player.getAngle() - 90))*(-inc*1.5);
      moves[1] = pa.y() + jump;
      moves[2] = pa.z() + cos(radians(player.getAngle() - 90))*(inc*1.5);
      
      pa.moveTo(moves, 0.35f);
      //pa.addForce(new float[]{0, -1.8, 0});
      pa.addGravity(new float[]{0, -0.8, 0});
      
      if (i > 62) break;
      i++;
    }
  }   
}
