// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top, bottom, and can detect collision with a paddle 
// CHANGED // and the score points // CHANGED //and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 7;
  int SIZE = 16;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The colour of the ball
  color ballColor = color(255);

  // CHANGED // The direction where the ball goes offscreen, which is necessary for scoring
  String offScreenDirection;

  // CHANGED // to know when the ball should jump and when it should stay on the ground
  // CHANGED // initially it should be on the ground so it's value is gonna be false
  boolean jumping = false;


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.
  // CHANGED // and also NOW, it checks wheter it should bounce of the score points or not

  // CHANGED // What the heck is Score Point ???

  // CHANGED // good question, Score points are small circles and each one represents one point
  // CHANGED // so as players get more points, there will be more of these circles in the game
  // CHANGED // so a wall  is going to be made between players, which the ball is going to bounce of 
  // CHANGED // when it's on the ground

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }

    // the ball bounces of the score points
    wallBounce();
  }

  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity

  void reset() {
    x = width/2;
    y = height/2;

    // CHANGED // each time ball start from the ground level
    jumping = false;
  }

  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")

  boolean isOffScreen() {
    // CHANGED // check if the ball is offscreen of not
    // CHANGED // if yes, from which side ?
    if (x + SIZE/2 < 0) {
      offScreenDirection = "OFF LEFT" ;
      return (true);
    } else if (x - SIZE/2 > width) {
      offScreenDirection = "OFF RIGHT";
      return (true);
    } else {
      return (false);
    }
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  // CHANGED // I changed it to boolean so we can know if they have collided or not so I can use it some where else

  boolean collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);

    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;

        // CHANGED // if the player has pressed the jump key and then the paddle and the ball
        // CHANGED // collided ... tell the ball to jump
        // CHANGED // when a player presses his/her jump key, his/her paddle is gonna move a bit in x axis
        // CHANGED // so thats why I put this condition to the if
        if (leftPaddle.x > leftPaddle.initialX) {
          jumping = true;
        } else {
          jumping = false;
        }
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;

        // CHANGED // Same thing for the other paddle
        //
        // CHANGED // if the player has pressed the jump key and then the paddle and the ball
        // CHANGED // collided ... tell the ball to jump
        // CHANGED // when a player presses his/her jump key, his/her paddle is gonna move a bit in x axis
        // CHANGED // so thats why I put this condition to the if
        if (rightPaddle.x < rightPaddle.initialX) {
          jumping = true;
        } else {
          jumping = false;
        }
      }
      // And make it bounce
      vx = -vx;
      // CHANGED // returns true if the ball and the paddle had collided
      return (true);
    }
    // CHANGED // else, it returns false
    return (false);
  }

  // CHANGED // wallBounce()
  // CHANGED //
  // CHANGED // checks if the ball and the score pointts collided, if yes ball bounces of them
  // CHANGED // if no, the ball continues its way
  // CHANGED // it also checks if the ball is jumping or not, if yes, the ball is not gonna collide 
  // CHANGED // with the score points and it jums over them

  void wallBounce() {
    // CHANGED // if the ball is not jumping, check the collision with the score points
    if (!ball.jumping) {
      // CHANGED // it strats checking if player on the left has any points 
      if (score.scoreLeft != 0) {
        // CHANGED // Calculate possible overlaps with the block of score points side by side
        boolean downInsideLeft = (ball.x + ball.SIZE/2 > width/2 - ball.SIZE/2);
        boolean downInsideRight = (ball.x - ball.SIZE/2 < width/2 + ball.SIZE/2);
        boolean downInsideTop = (ball.y + ball.SIZE/2 > (height - ball.SIZE) - (score.scoreLeft * ball.SIZE));
        boolean downInsideBottom = (ball.y - ball.SIZE/2 < height - ball.SIZE);

        // CHANGED // Check if the ball overlaps with the score wall (because now we are dealing with a block
        // CHANGED // of score points, I'm gonna name the 'score wall')
        if (downInsideLeft && downInsideRight && downInsideTop && downInsideBottom) {
          // CHANGED // If it was moving to the left
          if (ball.vx < 0) {
            // CHANGED // Reset its position to align with the right side of the player on the left's score wall
            ball.x =  width/2 + ball.SIZE;
          } else if (ball.vx > 0) {
            // CHANGED // Reset its position to align with the left side of the player on the left's score wall
            ball.x = width/2 - ball.SIZE;
          }
          // CHANGED // And make it bounce
          ball.vx = -ball.vx;
        }
      }
      // CHANGED // Same thing for the player on the right's score wall 
      // CHANGED // check if player on the right has any points
      if (score.scoreRight != 0) {
        // CHANGED // Calculate possible overlaps with the block of score points (score wall) side by side
        boolean upInsideLeft = (ball.x + ball.SIZE/2 > width/2 - ball.SIZE/2);
        boolean upInsideRight = (ball.x - ball.SIZE/2 < width/2 + ball.SIZE/2);
        boolean upInsideTop = (ball.y + ball.SIZE/2 > ball.SIZE);
        boolean upInsideBottom = (ball.y - ball.SIZE < ball.SIZE + (score.scoreRight * ball.SIZE));

        // CHANGED // Check if the ball overlaps with the score wall
        if (upInsideLeft && upInsideRight && upInsideTop && upInsideBottom) {
          // CHANGED // If it was moving to the left
          if (ball.vx < 0) {
            // Reset its position to align with the right side of the player on the right's score wall
            ball.x =  width/2 + ball.SIZE;
          } else if (ball.vx > 0) {
            // Reset its position to align with the left side of the player on the right's score wall
            ball.x = width/2 - ball.SIZE;
          }
          // CHANGED // And make it bounce
          ball.vx = -ball.vx;
        }
      }
    }
  }


  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    fill(ballColor);
    ellipseMode(CENTER);

    // Draw the ball
    ellipse(x, y, SIZE, SIZE);

    // CHANGED // if the ball shoud jump (the jumping value is true), it makes it jump
    // CHANGED // it's a mathematic formula which makes the ball bigger as it gets closer 
    // CHANGED // to the center of the frame and it gets smaller as it goes farther from the center
    if (jumping) {
      int distance = 120 - floor(dist(x, y, width/2, y)/(width/2) * 100);
      SIZE = distance;
    } else {
      SIZE = 16;
    }
  }
}