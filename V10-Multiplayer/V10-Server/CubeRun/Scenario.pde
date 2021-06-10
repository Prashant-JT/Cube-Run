public class Scenario {
  private color backColor;
  private PImage backImage = null;
  private PShape lane = null;

  public Scenario(color backColor, color laneColor) {
    this.backColor = backColor;
    initLane(laneColor);
  }

  public Scenario(PImage backImage, color laneColor) {
    this.backImage = backImage;
    initLane(laneColor);
  }

  private void initLane(color laneColor) {
    this.lane = createShape(RECT, 200, -200, -500, 500); 
    this.lane.setFill(laneColor);
  }

  void setBackground(color newColor) {
    this.backColor = newColor;
  }

  void setBackground(PImage newImage) {
    this.backImage = newImage;
  }

  void displayBackground() {
    if (backImage != null) {
      background(this.backImage);
    } else {
      background(this.backColor);
    }
  }

  void setLights() {
    // lights, materials
    // lights();
    pointLight(220, 180, 140, -1000, -1000, -100);
    ambientLight(96, 96, 96);
    directionalLight(210, 210, 210, -1, -1.5f, -2);
    lightFalloff(1.0f, 0.001f, 0.0f);
    lightSpecular(255, 0, 0);
    specular(255, 0, 0);    
    shininess(5);
  }  

  void displayLane() {
    pushMatrix(); 
    translate(100, -200);
    rotateX(PI/2);
    shape(lane);  
    popMatrix();
  }
}
