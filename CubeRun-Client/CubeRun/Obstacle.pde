public class Obstacle {

  private color colorShape;
  private int xPos;
  private int yPos;
  private int zPos;
  private int widthShape;
  private int heightShape;
  private int depthShape;

  public Obstacle (color colorShape, int [] params) {
    this.xPos = params[0];
    this.yPos = params[1];
    this.zPos = params[2];
    this.widthShape = params[3];
    this.heightShape = params[4];
    this.depthShape = params[5];
    this.colorShape = colorShape;
  }

  public boolean isLast() {
    return (this.colorShape == colorFinal);
  }

  public int [] getBoundsX() {
    return new int[]{this.xPos + this.widthShape/2, this.xPos - this.widthShape/2};
  }

  public int [] getBoundsY() {
    return new int[]{this.yPos + this.heightShape/2, this.yPos - this.heightShape/2};
  }

  public int [] getBoundsZ() {
    return new int[]{this.zPos + this.depthShape/2, this.zPos - this.depthShape/2};
  }

  public int getSize(char which) {
    switch (which) {
    case 'x':
      return this.widthShape/2;  
    case 'z':
      return this.depthShape/2;
    case 'y':
      return this.heightShape/2;
    }  
    return 0;
  }

  public void display () {
    pushMatrix();
    translate(this.xPos, this.yPos, this.zPos);
    noStroke();
    fill(this.colorShape);
    box(this.widthShape, this.heightShape, this.depthShape);
    popMatrix();
  }
}
