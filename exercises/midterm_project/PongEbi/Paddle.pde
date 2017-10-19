// Paddle
//
// A class that defines a paddle that can be moved up and down and a bit forward on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;
  int HEIGHT = 70;
  int WIDTH = 16;

  // CHANGED // declared to store the initial value of the paddle coordinates so we can
  // CHANGED // get back to it if we want to
  int initialX;
  int initialY;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;

  // The fill color of the paddle
  color paddleColor;

  // The characters used to make the paddle move up and down, defined in constructor
  char upKey;
  char downKey;

  // CHANGED // The character used to make the paddle move forward and makes the ball jump, defined in constructor
  char jumpKey;


  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey, char _jumpKey, color _paddleColor)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0
  // CHANGED // sets the paddle color

  Paddle(int _x, int _y, char _upKey, char _downKey, char _jumpKey, color _paddleColor) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    // CHANGED //
    paddleColor = _paddleColor;

    // CHANGED //
    initialX = _x;
    initialY = _y;

    upKey = _upKey;
    downKey = _downKey;

    // CHANGED //
    jumpKey = _jumpKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    y += vy;

    // Constrain the paddle's y position to be in the window
    y = constrain(y, 0 + HEIGHT/2, height - HEIGHT/2);

    // CHANGED // when the screen gets tighter, make the paddles move faster
    if (screenSizeChanged) {
      SPEED = 8;
    }
  }

  // CHANGED // reset ()
  // CHANGED //
  // CHANGED // It is called when the game ends and someone presses ENTER or RETURN
  // CHANGED // It resets the window size
  // CHANGED // set the right paddle's initialX to it initial value 
  // CHANGED // hence, places the paddles in their first position

  void reset() {

    windowWidth = 864;
    surface.setSize (windowWidth, windowHeight);

    rightPaddle.initialX = width - PADDLE_INSET;
    x = initialX;
    y = initialY;
  }

  // display()
  //
  // Display the paddle at its location

  void display() {
    // Set display properties
    noStroke();
    fill(paddleColor);
    rectMode(CENTER);

    // Draw the paddle as a rectangle
    rect(x, y, WIDTH, HEIGHT);
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      // If so we want a negative y velocity
      vy = -SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      // If so we want a positive y velocity
      vy = SPEED;
    } 
    
    // CHANGED // make the right paddle and left paddle move forward a bit (one step forward) (which means it wants to make the ball jump)
    if (key == jumpKey && jumpKey == '9') {
      rightPaddle.x= rightPaddle.x - WIDTH/2;
      // CHANGED // to limit its movement ... so it's not gonna move all the way forward if someone holds down th jump key
      rightPaddle.x = constrain(rightPaddle.x, rightPaddle.initialX - WIDTH/2, rightPaddle.initialX);
    } else if (key == jumpKey && jumpKey == '2') {
      leftPaddle.x= leftPaddle.x + WIDTH/2;
      // CHANGED // to limit its movement ... so it's not gonna move all the way forward if someone holds down th jump key
      leftPaddle.x = constrain(leftPaddle.x, leftPaddle.initialX, leftPaddle.initialX + WIDTH/2);
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    // Check if the key is our up key and the paddle is moving up
    if (key == upKey && vy < 0) {
      // If so it should stop
      vy = 0;
    } // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    } 
    // CHANGED // moves back the paddles to their position (one step backward)
    if (key == jumpKey && jumpKey == '9') {
      rightPaddle.x = rightPaddle.x + WIDTH/2;
    } else if (key == jumpKey && jumpKey == '2') {
      leftPaddle.x = leftPaddle.x - WIDTH/2;
    }
  }

 
  // CHANGED // replacePaddle ()
  // CHANGED //
  // CHANGED // it is called when the window size is changing, so it keeps the right paddle in the screen
  
  void replacePaddle() {
    x = windowWidth - PADDLE_INSET;
  }
}