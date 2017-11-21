// Import the Sprites library (you need to install
// it if you don't have it)
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;

// Create a Sprite for our avatar
Sprite avatar;

// Create a StopWatch to keep track of time passing
// (So we know how fast the animation should run.)
StopWatch timer = new StopWatch();

// How fast the avatar mores (pixels per second)
float avatarSpeed = 50; 

import ddf.minim.*;

float avatarSize = 1;

Minim minim;
AudioInput mic; // The class that lets us get at the microphone

boolean isShocked = false;
void setup() {
  size(500,500);
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
  rectMode(CENTER);
  // Get the current level (volume) going into the microphone
  
   // Sprites library stuff!
  // We get the time elapsed since the last frame (the deltaTime)
  double deltaTime = timer.getElapsedTime();
  // We update the sprites in the program based on that delta
  S4P.updateSprites(deltaTime);
  // Then we draw them on the screen
  S4P.drawSprites();
  
  float level = mic.mix.level();
  
      avatar.setFrameSequence(0, 0);
  if (level > 0.1){ 
    isShocked = true;
  }
  if (isShocked){
    avatar.setScale (avatarSize) ;
  avatar.setFrameSequence(1, 1);
  avatarSize = avatarSize + 0.1 ;
  avatarSize = constrain(avatarSize,1,6);
  }
  // Draw a rectangle with dimensions defined by microphone level
  //rect(width/2, height/2, width/5, height/5);
  //println (level);
}