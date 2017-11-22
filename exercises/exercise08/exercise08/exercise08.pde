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

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y (which I'm setting to -1, -1
// as a default value)
PVector reddestPixel = new PVector(-1, -1);
PVector bluestPixel = new PVector(-1, -1);

void setup() {
  size(640, 480);

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();

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
  background(255);
  handleVideoInput();

  pushMatrix();
  translate(video.width/2, height/2);
  scale(-1, 1);
  image(video, 0, 0);
  popMatrix();

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
  if (level > 0.1) { 
    isShocked = true;
  }
  if (isShocked) {
    avatar.setScale (avatarSize) ;
    avatar.setFrameSequence(1, 1);
    avatarSize = avatarSize + 0.1 ;
    avatarSize = constrain(avatarSize, 1, 6);
  }

  // For now we just draw a crappy ellipse at the reddest pixel
  fill(#ff0000);
  stroke(#ffff00);
  strokeWeight(7);
  ellipse(reddestPixel.x, reddestPixel.y, 20, 20);
  
    // and we draw another crappy ellipse at the bluest pixel
  fill(#0000ff);
  stroke(#ffff00);
  strokeWeight(7);
  ellipse(bluestPixel.x, bluestPixel.y, 20, 20);
}

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();
  redDetection();
  blueDetection();
}

void redDetection () {
  float record = 1000;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the reddest of the pixel we're looking at an stores it's location

      float amount = dist(255, 0, 0, red(pixelColor), green(pixelColor), blue(pixelColor));
      // this if for the accuracy of the red detection! 
      // now because of my room's shitty lighting, I reduced the accuracy a bit ...
      // fill free to adjust the sensitivity according your room's lighting condition.
      if (red(pixelColor) > 120 && green(pixelColor) < 50 && blue(pixelColor) < 50 && amount < record) {
        record = amount;
        reddestPixel.x = width - x;
        reddestPixel.y = y;
      }
    }
  }
}

void blueDetection () {
  float record = 1000;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // Get the blueest of the pixel we're looking at an stores it's location

      float amount = dist(0, 0, 255, red(pixelColor), green(pixelColor), blue(pixelColor));
      // this if for the accuracy of the blue detection! 
      // again, now because of my room's shitty lighting, I reduced the accuracy a bit ...
      // fill free to adjust the sensitivity according your room's lighting condition.
      if (red(pixelColor) < 50 && green(pixelColor) < 50 && blue(pixelColor) > 100 && amount < record) {
        record = amount;
        bluestPixel.x = width - x;
        bluestPixel.y = y;
      }
    }
  }
}