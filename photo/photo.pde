import processing.video.*;

Capture cam;
PImage img;

void setup() {
  size(640, 480);
  
  // Get all available cameras
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) println(cameras[i]);

    // Capture from the selected camera
    cam = new Capture(this, cameras[1]);
    cam.start();
  }
}

void draw() {
  if (img != null) {
    // Show last saved image
    background(0);
    noFill();
    stroke(255);
    strokeWeight(3);
    set(10, 10, img);
    rect(8, 8, 70, 60, 5);
  } else {
    if (cam.available() == true) cam.read();
      // image(cam, 0, 0);
      // The following does the same, and is faster when just drawing the image
      // without any additional resizing, transformations, or tint.
      set(0, 0, cam);
  }
}

void mouseClicked() {
  // Saves each frame as photo.png
  saveFrame("photo.png");
  println("Photo clicked");
  img = loadImage("photo.png");
  img.resize(70, 60);
}
