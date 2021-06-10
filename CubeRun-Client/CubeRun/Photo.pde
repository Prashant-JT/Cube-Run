import processing.video.*;

class Photo {
  private Capture cam;
  private boolean error;
  private PImage img = null;
  private PApplet context;
  private String[] cameras;
  private PImage cKey;

  public Photo(PApplet context) {
    this.context = context;
    cKey = loadImage("cKey.png");
    // Get all available cameras
    cameras = Capture.list();

    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      error = true;
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) println(cameras[i]);
    }
  }

  public boolean getError() {
    return this.error;
  }

  void startCam() {    
    this.img = null; 
    cam = new Capture(this.context, 600, 400, cameras[0]);
    cam.start();
  }

  void stopCamera() {
    cam.stop();
  }

  void display() {
    if (img != null) {
      noFill();
      stroke(255);
      strokeWeight(3);
      set(8, 8, img);
    } else {
      if (cam.available() == true) cam.read();
      image(cam, (w/2)-300, (h/2)-400);
      //fill(255);
      textAlign(CENTER);
      textSize(20);
      image(cKey, width/2 - 25, height/2 + 90);
      text("TO CLICK A PROFILE PICTURE", width/2, width/2 + 280);
    }
  }

  void photoSetImage() {
    saveFrame("photo.png");
    img = loadImage("photo.png");
    img = img.get((w/2)-300, (h/2)-400, 600, 400);
    img.resize(70, 60);
  }
}
