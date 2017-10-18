// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

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
  
  //
  String offScreenDirection;
  
  //
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

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
    
    //
     wallBounce();
  }
  
  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity
  
  void reset() {
    x = width/2;
    y = height/2;
    
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
    if (x + SIZE/2 < 0){
      offScreenDirection = "OFF LEFT" ;
      return (true); 
    } else if (x - SIZE/2 > width){
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
        if (leftPaddle.x > leftPaddle.initialX){
          jumping = true;
        } else {
        jumping = false;
      }
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
        if (rightPaddle.x < rightPaddle.initialX){
          jumping = true;
        } else {
        jumping = false;
      }
      }
      // And make it bounce
      vx = -vx;
     
      return (true);
    }
    return (false);
  }

  //
  
  void wallBounce() {
    if (!ball.jumping){
    if (score.scoreLeft != 0) {
      // Calculate possible overlaps with the paddle side by side
      boolean downInsideLeft = (ball.x + ball.SIZE/2 > width/2 - ball.SIZE/2);
      boolean downInsideRight = (ball.x - ball.SIZE/2 < width/2 + ball.SIZE/2);
      boolean downInsideTop = (ball.y + ball.SIZE/2 > (height - ball.SIZE) - (score.scoreLeft * ball.SIZE));
      boolean downInsideBottom = (ball.y - ball.SIZE/2 < height - ball.SIZE);
      
      // Check if the ball overlaps with the paddle
      if (downInsideLeft && downInsideRight && downInsideTop && downInsideBottom) {
        // If it was moving to the left
        if (ball.vx < 0) {
          // Reset its position to align with the right side of the paddle
          ball.x =  width/2 + ball.SIZE;
        } else if (ball.vx > 0) {
          // Reset its position to align with the left side of the paddle
          ball.x = width/2 - ball.SIZE;
        }
        // And make it bounce
        ball.vx = -ball.vx;
      }
    }
    if (score.scoreRight != 0){
      // Calculate possible overlaps with the paddle side by side
      boolean upInsideLeft = (ball.x + ball.SIZE/2 > width/2 - ball.SIZE/2);
      boolean upInsideRight = (ball.x - ball.SIZE/2 < width/2 + ball.SIZE/2);
      boolean upInsideTop = (ball.y + ball.SIZE/2 > ball.SIZE);
      boolean upInsideBottom = (ball.y - ball.SIZE < ball.SIZE + (score.scoreRight * ball.SIZE));
      
      // Check if the ball overlaps with the paddle
      if (upInsideLeft && upInsideRight && upInsideTop && upInsideBottom) {
        // If it was moving to the left
        if (ball.vx < 0) {
          // Reset its position to align with the right side of the paddle
          ball.x =  width/2 + ball.SIZE;
        } else if (ball.vx > 0) {
          // Reset its position to align with the left side of the paddle
          ball.x = width/2 - ball.SIZE;
        }
        // And make it bounce
        ball.vx = -ball.vx;
      }
    }
    }
  }
  
  
  
  
  //
  
  void jump(){
    
    int distance = 120 - floor(dist(x,y,width/2,y)/(width/2) * 100);
    SIZE = distance;
    
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
    if (jumping){
    int distance = 120 - floor(dist(x,y,width/2,y)/(width/2) * 100);
    SIZE = distance;
    } else {
    SIZE = 16;
  }
  }
}