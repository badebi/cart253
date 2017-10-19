// PongEbi
//
// A new version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// The game get harder and harde as Players get a higher score. 
// A wall is going to be made from their points, which makes the
// ball bounce back to their field; so players should hit the ball in
// a specific way to make it jump over the wall and lead it to the
// other side.
// 


//
// Cool scoring.
// Awesome score display.
// still Pretty ugly. just a bit better :D
// top view 3D simulator. B)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// CHANGED global variable for the score
Score score;


// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// CHANGED The background colour during play (dark green)
color backgroundColor = #0F3902;

// CHANGED I declared these to be able to change the screen size during the game
int windowWidth = 864;
int windowHeight = 480;

// CHANGED To know if the screen size has changed or not
boolean screenSizeChanged = false;

// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // CHANGED Set the initial size and tells the program that it's gonna changed
  size(864, 480);
  surface.setResizable(true);


  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // CHANGED Also pass through the two keys used to control 'up', 'down' and 'jump key' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, windowHeight/2, '1', 'q', '2', #FF0000);
  rightPaddle = new Paddle(windowWidth - PADDLE_INSET, windowHeight/2, '0', 'p', '9', #0000FF);

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);

  // 
  score = new Score();
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // CHANGED // I used this if and else to have different things shown when the game is in progress
  // CHANGED // and when it is ended. so with this 'if' the game has ending.
  //
  // CHANGED // so if non of the players has reached to the final score, these things going to happen
  if (score.scoreRight < score.winnerScore && score.scoreLeft < score.winnerScore) {

    // Fill the background each frame so we have animation
    background(backgroundColor);

    // Update the paddles and ball by calling their update methods
    leftPaddle.update();
    rightPaddle.update();
    ball.update();

    // CHANGED // Update the score baay calling its update method
    score.update();


    // Check if the ball has collided with either paddle
    ball.collide(leftPaddle);
    ball.collide(rightPaddle);

    // Check if the ball has gone off the screen
    if (ball.isOffScreen()) {
      // If it has, reset the ball
      ball.reset();
    }

    // Display the paddles
    leftPaddle.display();
    rightPaddle.display();


    // CHANGED // display the score and the ball
    score.display();
    ball.display();

    // CHANGED // checks if either of players reaches to the half of the
    // CHANGED // final score, so then the screen width starts to get smaller
    if (score.scoreRight > floor(score.winnerScore / 2) || score.scoreLeft > floor(score.winnerScore / 2) ) {
      // CHANGED // setting the window size to the new values 
      surface.setSize (windowWidth, windowHeight);
      // CHANGED // makes the width 1 pixel smaller in each frame
      windowWidth --;
      // CHANGED // limit the amount of resizing 
      windowWidth = constrain(windowWidth, 680, 1080);
      
      // CHANGED // this if is to change right paddle's location and keeps it in the screen
      if (windowWidth > 680) {
        // CHANGED // so it calls a method in Paddle class which is gonna do it
        rightPaddle.replacePaddle();
      }
      // CHANGED // because we are already in this if, so it means that screen size has changed
      // CHANGED // so we put this in a boolean which is declared at the beginning
      screenSizeChanged = true;
    }
  } else {
    // CHANGED // every thing in here is for when the game finishes, which is when one of the players
    // CHANGED // reaches to the final score (winnerScore)
    background(backgroundColor); 
    // CHANGED // calls a method from Score which gonna say who is the winner and who is the looser
    score.winner();
    
    // CHANGED // players still can move their paddles and have fun
    leftPaddle.update();
    rightPaddle.update();
    leftPaddle.display();
    rightPaddle.display();

    // CHANGED // I put this here so players will be able to restart the whole game and play again
    score.keyPressed();
  }
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}