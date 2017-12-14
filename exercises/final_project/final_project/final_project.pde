// S.SH.OUT O.P. (a.k.a Scare the SHit OUT Of People) #Final_Project
// by Ebarahim Badawi (Ebby)

// This game takes you to a park in a such beautiful day ... you sit on a bench
// and enjoy watching people passing by. you get bored, take your newspaper out
// and start shouting to scare the sh*t out of people, then you hide behind the
// newspaper so people cannot find you! SO SIMPLE, you come out from behind of 
// the newspaper, you shout, scare thatGuy, and then take a cover behind the 
// newspaper as soon as you can.

// This game uses a redDetection and blueDetection, so please, before runnig it
// make sure that you're not wearing anything red or blue from waist up. Also,
// if the game developer "EBBY" has not prepare you with the stuff you need to 
// play this game, make sure that you have 1) a newspaper with two holes on it
// for your eyes and a BLUE point or a blue bar on the top of it (facing the 
// webcam) and 2) a RED point one your forehead.
//
// Because of different lighting in different places, make sure to adjust the 
// colorDetector thresholds in the games setting so you face no problems.
//
// If you still have problems to equip yourself for playing this game, grab your
// phone right now and call +1 (438) 880-2080, to get the especial SSHOUT OP
// package before chritmas.
//
// ENJOY!

//_________________________________________________________________________________

// Importing the liberaries we need
import sprites.*;
import sprites.maths.*;
import sprites.utils.*;
import ddf.minim.*;
import processing.video.*;

// Creat a minim to be able to use sound
Minim minim;
// The class that lets us get at the microphone
AudioInput mic; 

// Declare a Score for managing the score
Score score;
// Declare an animation where all the magic happens
Animation animation;
// Declare Sprites for our background, avatar and newspaper
Sprite avatar;
Sprite background;
Sprite newspaperSprite;
// Declare two color detectors, red and blue
ColorDetector redDetector;
ColorDetector blueDetector;

// To know whichstage we are at during the game and what stage we're coming from
String gameStage;
String prvGameStage;

// Two new fonts which are gonna be used in the game
PFont myDopeFont;
PFont myNiceShadedFont;

// There are two setting pages in the sprite so I made a variable just for that
// to be able to swith between them easily
int settingPage = 35;

// Create a StopWatch to keep track of time passing
// (So we know how fast the animation should run.)
StopWatch timer = new StopWatch();

// The capture object for reading from the webcam
Capture video;

// A variable to know if the player is hidden behind the newspaper or not
boolean playerIsHidden = false;

// To know if thw game is over or not
boolean gameIsOver = false;

// This is to switch between the two color detectors using shift key while 
// adjusting them.
int thresholdSwitch = 0;

//_________________________________________________________________________________setup()

// The basic setup of the game 

void setup() {
  // set the window size
  size(640, 480);

  // load the fonts and bring them in
  myDopeFont = loadFont("myDopeFont.vlw");
  myNiceShadedFont = loadFont("myNiceShadedFont.vlw");

  // Create our Sprites by providing "this", the file with the spritesheet, the number 
  // of columns in the sheet, the number of rows in the sheet, and the z-depth of these
  // sprite
  background = new Sprite(this, "BackgroundPark.png", 3, 4, 0);
  avatar = new Sprite(this, "ThatGuyNew.png", 3, 4, 1);
  newspaperSprite = new Sprite(this, "NewspaperSprite.png", 5, 8, 2);

  // Create the animation and the score
  animation = new Animation();
  score = new Score();

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();

  // Start detecting the colors, it gets (String: color to detect "red" "green" or "blue",
  // boolean: to show or not to show on screen, String: display type "line" or "ellipse" 
  redDetector = new ColorDetector("red", false, "line");
  blueDetector = new ColorDetector("blue", false, "line");

  // Creating a minim
  minim = new Minim(this);
  // We use minim.getLineIn() to get access to the microphone data
  mic = minim.getLineIn();
}

//_________________________________________________________________________________draw()

void draw() {
  // To check if there is any video or not and to flip the video horizantally to make it
  // as if it's a mirror
  handleVideoInput();

  // handles everything related to the animation
  animation.handleAnimation();

  // Detect the color Blue on the webcam and if the player is not hidden behind the 
  // newspaper, it starts detecting the color RED as well wich is the player's head
  blueDetector.detect();
  if (!playerIsHidden) {
    redDetector.detect();
  }
}

//_________________________________________________________________________________handleVideoInput()

// checks if there is any video, and flips the video horizantally to make it as if it's a mirror

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Flip the video horizantally
  pushMatrix();
  translate(video.width/2, height/2);
  scale(-1, 1);
  //image(video, 0, 0);
  popMatrix();
}

//_________________________________________________________________________________keyPressed()

// Is called when a key is pressed
// Adjusts the threshold for the colorDetector (both for BLUE and RED), using UP and DOWN
// arrow keys and SHIFT for changing between blue and red
// Also by pressing SPACE, you can turn the editing mode while playing, so you can adjust 
// the tresholds on the spot and use the red and blue line as a hint

void keyPressed() {
  // If we are in the settings or while you are playing and the color display is on, gives
  // you the ability to change the treshold
  if (gameStage == "setting" || (gameStage == "start" && blueDetector.display)) {

    // SHIFT key to change between RED and BLUE back and forth
    if (keyCode == SHIFT) {
      // A math trick to change between 0 and 1
      thresholdSwitch = 1 - thresholdSwitch;
    }

    if (thresholdSwitch == 0) {
      // call keyPressed() from blue color detector
      blueDetector.keyPressed();
      // set the setting page for adjusting the blue treshold
      settingPage = 35;
      // Print it so you can see the number while playing
      println("blue = " + blueDetector.threshold);
    } else if (thresholdSwitch == 1) {
      // call keyPressed() from blue color detector
      redDetector.keyPressed();
      // set the setting page for adjusting the red treshold
      settingPage = 36;
      // Print it so you can see the number while playing
      println("red = " + redDetector.threshold);
    }
  }
  // Turns the editing mode ON and OFF, so you can see the red and blue line on the screen (where
  // the colors are detected), you can adjust the tresholds and also you can see some point on the
  // locations that the colors are spoted
  if (keyCode == 32) {
    redDetector.display = !redDetector.display;
    blueDetector.display = !blueDetector.display;
  }
}

//_________________________________________________________________________________mouseClicked()

// The only part you need to use the mouse is in the menu to go to the settings and come back
// to menu.
void mouseClicked() {
  if (mouseX > 400 && mouseX < 500 && mouseY > 430 && mouseY < 460) {
    animation.mouseClicked();
  }
}