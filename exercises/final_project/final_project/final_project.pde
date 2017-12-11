// Final Project
// by Ebarahim Badawi (Ebby)

// Import the Sprites library (you need to install
// it if you don't have it)

//--------------------------------------------------------------------------
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;
import ddf.minim.*;
import processing.video.*;

Minim minim;
AudioInput mic; // The class that lets us get at the microphone

Animation animation;
// Create a Sprite for our avatar
Sprite avatar;
Sprite background;

// Create a StopWatch to keep track of time passing
// (So we know how fast the animation should run.)
StopWatch timer = new StopWatch();


// The capture object for reading from the webcam
Capture video;

ColorDetector redDetector;
ColorDetector blueDetector;

boolean playerIsHidden = false;

int thresholdSwitch = 0;

//-----------------------------------------------------------------------
void setup() {
  size(640, 480);

  // Create our Sprite by providing "this", the file
  // with the spritesheet, the number of columns in the
  // sheet, the number of rows in the sheet, and the
  // z-depth of this sprite

  background = new Sprite(this, "BackgroundPark.png", 3, 4, 0);
  avatar = new Sprite(this, "avatar.png", 1, 2, 0);


  animation = new Animation();

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();

  redDetector = new ColorDetector("red", true, "line");
  blueDetector = new ColorDetector("blue", true, "line");


  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
}

//-------------------------------------------------------------------
void draw() {
  background(125);

  handleVideoInput();
  animation.handleAnimation();
  blueDetector.detect();
  if (!playerIsHidden) {
    redDetector.detect();
  }
}

//----------------------------------------------------------------------
void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();

  pushMatrix();
  translate(video.width/2, height/2);
  scale(-1, 1);
  //image(video, 0, 0);
  popMatrix();
}

//------------------------------------------------------------------------------

void keyPressed() {
  if (keyCode == SHIFT) {
    thresholdSwitch = 1 - thresholdSwitch;
  }
  if (thresholdSwitch == 0) {
    blueDetector.keyPressed();
    println("blue =" + blueDetector.threshold);
  } else if (thresholdSwitch == 1) {
    redDetector.keyPressed();
    println("red =" + redDetector.threshold);
  }
  animation.keyPressed();
}