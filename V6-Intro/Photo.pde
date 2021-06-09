import processing.video.*;

class Photo {
  private Capture cam;
  private PImage img;
  private PApplet context;
  private String[] cameras;

  public Photo(PApplet context) {
    this.context = context;
    // Get all available cameras
    cameras = Capture.list();

    if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      for (int i = 0; i < cameras.length; i++) println(cameras[i]);
    }
  }

  void startCam() {
    // Capture from the selected camera
    cam = new Capture(this.context, 600, 400, cameras[1]);
    cam.start();
  }

  void display() {
    img = loadImage("photo.png");
    if (img != null) {
      // Show last saved image
      background(0);
      noFill();
      stroke(255);
      strokeWeight(3);
      image(img, 500, 500);
      rect(8, 8, 70, 60, 5);
    } else {
      println("ahora si");
      if (cam.available() == true) cam.read();
      image(cam, 0, 0);
    }
  }

  void photoSetImage() {
    // Saves each frame as photo.png
    saveFrame("photo.png");
    println("Photo clicked");
    img = loadImage("photo.png");
    if (img != null) {
      println("no estas a nulo chaval");
    }
    //img = img.get(0, 0, 600, 400);
    //img.resize(70, 60);
  }
}
