// Final Project
// by Ebarahim Badawi (Ebby)

// Import the Sprites library (you need to install
// it if you don't have it)

//_________________________________________________________________________________

import sprites.*;
import sprites.maths.*;
import sprites.utils.*;
import ddf.minim.*;
import processing.video.*;



Minim minim;
AudioInput mic; // The class that lets us get at the microphone

Score score;
Animation animation;
// Create a Sprite for our avatar
Sprite avatar;
Sprite background;
Sprite newspaperSprite;

String gameStage;
String prvGameStage;

PFont    myDopeFont;
PFont    myNiceShadedFont;

int settingPage = 35;

ArrayList<Sprite> thoseGuys = new ArrayList<Sprite>();

// Create a StopWatch to keep track of time passing
// (So we know how fast the animation should run.)
StopWatch timer = new StopWatch();


// The capture object for reading from the webcam
Capture video;

ColorDetector redDetector;
ColorDetector blueDetector;

boolean playerIsHidden = false;

boolean gameIsOver = false;

int thresholdSwitch = 0;

//_________________________________________________________________________________

void setup() {
  size(640, 480);

  myDopeFont = loadFont("myDopeFont.vlw");
  myNiceShadedFont = loadFont("myNiceShadedFont.vlw");

  // Create our Sprite by providing "this", the file
  // with the spritesheet, the number of columns in the
  // sheet, the number of rows in the sheet, and the
  // z-depth of this sprite

  background = new Sprite(this, "BackgroundPark.png", 3, 4, 0);
  avatar = new Sprite(this, "ThatGuyNew.png", 3, 4, 1);
  newspaperSprite = new Sprite(this, "NewspaperSprite.png", 5, 8, 2);


  animation = new Animation();

  score = new Score();

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();

  redDetector = new ColorDetector("red", false, "line");
  blueDetector = new ColorDetector("blue", false, "line");


  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
}

//_________________________________________________________________________________

void draw() {
  handleVideoInput();
  animation.handleAnimation();
  blueDetector.detect();
  if (!playerIsHidden) {
    redDetector.detect();
  }
}

//_________________________________________________________________________________

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

//_________________________________________________________________________________

void keyPressed() {
  if (gameStage == "setting" || (gameStage == "start" && blueDetector.display)) {
    if (keyCode == SHIFT) {
      thresholdSwitch = 1 - thresholdSwitch;
    }
    if (thresholdSwitch == 0) {
      blueDetector.keyPressed();
      settingPage = 35;
      println("blue = " + blueDetector.threshold);
    } else if (thresholdSwitch == 1) {
      redDetector.keyPressed();
      settingPage = 36;
      println("red = " + redDetector.threshold);
    }

    //animation.keyPressed();
  }
  if (keyCode == 32) {
    redDetector.display = !redDetector.display;
    blueDetector.display = !blueDetector.display;
  }
}

//_________________________________________________________________________________

void mouseClicked() {
  if (mouseX > 400 && mouseX < 500 && mouseY > 430 && mouseY < 460) {
    animation.mouseClicked();
  }
}