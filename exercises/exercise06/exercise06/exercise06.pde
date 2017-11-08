// Exercise 06
//Ebrahim Badawi (Ebby)
//
// Using the webcam as input to play with Bullets (MATRIX SIMULATION)

// Import the video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y (which I'm setting to -1, -1
// as a default value)
PVector reddestPixel = new PVector(-1, -1);

// An array of bouncers to play with
Bullet[] bullets = new Bullet[20];

// To know if the hand is up or not
boolean handIsUp = false;

// setup()
//
// Creates the bouncers and starts the webcam

void setup() {
  size(640, 480);

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bullets.length; i++) {
    // Each Bouncer just starts with random values 
    // the vy will be consistant
    bullets[i] = new Bullet(random(0, width), random(0, height), 1, random(200, 250), color(0, random(110, 150), 0));
  }

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
}

// draw()
//
// Processes the frame of video, draws the video to the screen and detects the edges, updates the bullets
// and then just draws an ellipse at the reddest pixel location.

void draw() {
  // A function that processes the current frame of video
  handleVideoInput();

  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bullets.
  // If the redness (or other video property) is going to interact with all the
  // Bullets, it will need to happen in here.
  for (int i = 0; i < bullets.length; i++) {
    bullets[i].update(handIsUp);
    bullets[i].display();
  }

  // For now we just draw a crappy ellipse at the reddest pixel
  fill(#ff0000);
  stroke(#ffff00);
  strokeWeight(7);
  ellipse(reddestPixel.x, reddestPixel.y, 20, 20);
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
  matrixWorld();
  redDetection();
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
      if (red(pixelColor) > 100 && green(pixelColor) < 50 && blue(pixelColor) < 50 && amount < record) {
        record = amount;
        reddestPixel.x = x;
        reddestPixel.y = y;
      }
      // if it doesn't detect any red spot, it means the hand is not up so the bullets will continue to be fired
      handIsUp = (record != 1000);
    }
  }
}

// Simply it detects the edges and gives us a Matrix like look
void matrixWorld() {
  float greenness = random(25, 255);
  // Draw the video frame to the screen
  image(video, 0, 0);
  loadPixels();
  for ( int x = 1; x < video.width; x++ ) {
    for ( int y = 0; y < video.height; y++ ) {
      float threshold = 10;
      int loc = x + y*video.width;
      color pix = video.pixels[loc];
      int leftLoc = (x-1) + y*video.width;
      color leftPix = video.pixels[leftLoc];
      float diff = abs(brightness(pix) -  brightness(leftPix));
      if ( diff > threshold ) {
        pixels[loc] = color(0, greenness, 0, 15);
      } else {
        pixels[loc] = color(0, 15);
      }
    }
  }
  updatePixels();
}