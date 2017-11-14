// Exercise 07
// Ebrahim Badawi (Ebby)
//
// 

// Import the video and sound library
import processing.video.*;

import processing.sound.*;

//
SoundFile kick;
SoundFile snare;
SoundFile snare2;
SoundFile highHat;

SoundFile currentSound;

SinOsc sine;

int framesPerBeat = 20;


// The capture object for reading from the webcam
Capture video;

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y (which I'm setting to -1, -1
// as a default value)
PVector reddestPixel = new PVector(-1, -1);
PVector bluestPixel = new PVector(-1, -1);


// To know if the hand is up or not
boolean handIsUp = false;

void setup() {
  size(640, 480);

  //
  kick = new SoundFile(this, "sounds/kick.wav");
  snare = new SoundFile(this, "sounds/snare.wav");
  snare2 = new SoundFile(this, "sounds/snare 2.wav");
  highHat = new SoundFile(this, "sounds/highHat.wav");
  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
  
    // Create the sine oscillator.
  sine = new SinOsc(this);
  // Start it, ooooooooo
  sine.play();
}

// draw()
//
// Processes the frame of video, draws the video to the screen and detects the edges, updates the bullets
// and then just draws an ellipse at the reddest pixel location.

void draw() {
  // A function that processes the current frame of video
  handleVideoInput();
  handleDrums();

  //
  pushMatrix();
  translate(video.width, 0);
  scale(-1, 1);
  image(video, 0, 0);
  popMatrix();
  
  // Map the bluestPixel.x to control the frequency
  sine.freq(map(bluestPixel.x,0,width,110,880));
  // Map the bluestPixel.y to control the amplitude
  sine.amp(map(bluestPixel.y,0,height,1,0));



  // For now we just draw a crappy ellipse at the reddest pixel
  fill(#ff0000);
  stroke(#ffff00);
  strokeWeight(7);
  ellipse(reddestPixel.x, reddestPixel.y, 20, 20);

  fill(#0000ff);
  stroke(#ffff00);
  strokeWeight(7);
  ellipse(bluestPixel.x, bluestPixel.y, 20, 20);
}

// handleVideoInput
//
// Checks for available video, reads the frame, manipulate it and takes us to the
// world of Matrix, and then finds the reddest pixel
// in that frame and stores its location in reddestPixel.

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

void handleDrums() {
  boolean topLeftPad = (reddestPixel.x < width / 2 && reddestPixel.y < height / 2 && reddestPixel.x != 0 && reddestPixel.y != 0);
  boolean botLeftPad = (reddestPixel.x < width / 2 && reddestPixel.y > height / 2);
  boolean topRightPad = (reddestPixel.x > width / 2 && reddestPixel.y < height / 2);
  boolean botRightPad = (reddestPixel.x > width / 2 && reddestPixel.y > height / 2);
  boolean inCenter = (width / 2 - 50 < reddestPixel.x && reddestPixel.x < width / 2 + 50 && height /2 - 50 < reddestPixel.y && reddestPixel.y < height / 2 + 50);

  if (!inCenter) {
  //if (frameCount % framesPerBeat == 0) {
  if (topLeftPad && currentSound != kick) {
    kick.play();
    currentSound = kick;
  }
  if (topRightPad && currentSound != highHat) {
    highHat.play();
    currentSound = highHat;
  }
  if (botLeftPad && currentSound != snare) {
    snare.play();
    currentSound = snare;
  } 
  if (botRightPad && currentSound != snare2) {
    snare2.play();
    currentSound = snare2;
  }
  //}
  } else {
    currentSound = null;
  }
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
      // if it doesn't detect any red spot, it means the hand is not up so the bullets will continue to be fired
      handIsUp = (record != 1000);
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
      // Get the reddest of the pixel we're looking at an stores it's location

      float amount = dist(0, 0, 255, red(pixelColor), green(pixelColor), blue(pixelColor));
      // this if for the accuracy of the red detection! 
      // now because of my room's shitty lighting, I reduced the accuracy a bit ...
      // fill free to adjust the sensitivity according your room's lighting condition.
      if (red(pixelColor) < 50 && green(pixelColor) < 50 && blue(pixelColor) > 100 && amount < record) {
        record = amount;
        bluestPixel.x = width - x;
        bluestPixel.y = y;
      }
      // if it doesn't detect any red spot, it means the hand is not up so the bullets will continue to be fired
      handIsUp = (record != 1000);
    }
  }
}