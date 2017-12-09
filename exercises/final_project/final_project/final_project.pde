// Final Project
// by Ebarahim Badawi (Ebby)

// Import the Sprites library (you need to install
// it if you don't have it)
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

import ddf.minim.*;

// Import the video library
import processing.video.*;

// Create a Sprite for our avatar
Sprite avatar;

// Create a StopWatch to keep track of time passing
// (So we know how fast the animation should run.)
StopWatch timer = new StopWatch();

// How fast the avatar mores (pixels per second)
float avatarSpeed = 50; 
float avatarSize = 1;

Minim minim;
AudioInput mic; // The class that lets us get at the microphone

boolean isShocked = false;


// The capture object for reading from the webcam
Capture video;

ColorDetector redDetector;
ColorDetector greenDetector;
ColorDetector blueDetector;

PImage newspaper;

float newsPaperY = 580;

void setup() {
  size(640, 480);

  newspaper = loadImage ("newspaper2.png");

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();

  redDetector = new ColorDetector("red", true);
  blueDetector = new ColorDetector("blue", true);


  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();

  // Create our Sprite by providing "this", the file
  // with the spritesheet, the number of columns in the
  // sheet, the number of rows in the sheet, and the
  // z-depth of this sprite
  avatar = new Sprite(this, "avatar.png", 1, 2, 0);
  // Set the avatar's position on screen
  avatar.setXY(width/2, height/2);
  // Set the default (idle) frame sequence from the
  // sheet to animate
  avatar.setFrameSequence(1, 1);
}

void draw() {
  background(125);

  handleVideoInput();
  
  redDetector.detect();
  blueDetector.detect();
  
  handleAnimation();

  image (newspaper, width/2, newsPaperY );
  newsPaperY = 300 + blueDetector.brightestPixel.y;

  blueDetector.display();
  redDetector.display();
}

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

void handleAnimation() {
  // Sprites library stuff!
  // We get the time elapsed since the last frame (the deltaTime)
  double deltaTime = timer.getElapsedTime();
  // We update the sprites in the program based on that delta
  S4P.updateSprites(deltaTime);
  // Then we draw them on the screen
  S4P.drawSprites();

  // Get the current level (volume) going into the microphone
  float level = mic.mix.level();

  avatar.setFrameSequence(0, 0);

  // If the avatar goes off the left or right
  // wrap it around
  if (avatar.getX() > width) {
    avatar.setX(avatar.getX() - width);
  } else if (avatar.getX() < 0) {
    avatar.setX(avatar.getX() + width);
  }

  avatar.setVelXY (-100, 0);

  //float velX = map(level,-100, 0,0,0.5);

  //if (level > 0.06) {
  // avatar.setVelXY (velX, 0);
  //}
  if (level > 0.1) { 
    isShocked = true;
  }
  if (isShocked) {
    avatar.setScale (avatarSize) ;
    avatar.setFrameSequence(1, 1);
    avatarSize = avatarSize + 0.1 ;
    avatarSize = constrain(avatarSize, 1, 6);
    avatar.setVelXY (0, 0);
    newsPaperY += 5;
    newsPaperY = constrain(newsPaperY, 580, 780);
  }
}