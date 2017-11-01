// Ball
//
// A class that defines a ball that can move around in the window, bouncing 
// along the z axis (in 2D, but it can be perceived as 3D) of the racket
class Ball {
  // theta is used with sin function to give us the oscillation feel
  float theta = 0;
  float x;
  float y;
  float size;
  float growth;
  color ballColor;

  int score = 0;
  
  // to know if the ball is bouncing or it has fell
  boolean bouncing = true;

  // are used with noise function to change the balls behavior while bouncing
  float tx = random(0, 100);
  float ty = random(0, 100);

  // The constructor sets the variable to their starting values
  // x, y and size are set to the arguments passed through (from the main program)
  Ball (int _x, int _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
    // the color of the ball is white ... or for make it harder you can make it as same as 
    // background color
    ballColor = #ffffff;
  }

 // it is called once each frame and it updates the ball and checks it it hits the racket or not
  void update() {
    // if the ball is bouncing, it's gonna bounce !!!
    if (bouncing) {
      // makes the size og the ball change so we feel that we're watchig the ball from the top view
      // and changes its position to make the game more enjoable
      growth = sin(theta) * (2 * size/3);
      x = width * noise(tx);
      y = height * noise(ty);
      // theta will declares how fast the ball will bounce
      theta += PI/20;
      tx += 0.01;
      ty += 0.01;
      
      // in the lowest part (the smallest size of the ball) it checks if it hits the 
      // racket or not
      if (sin(theta) == -1) {
        colliding();
      }
    } else {
     // if the ball is not bouncig ( didn't hit the racket) it's gonna fall
      growth -= 10;
      if (growth < -size) {
        growth = -size;
      }
    }
  }

  void colliding () {
    // if the ball has fallen, sodon't check anythhing
    if (!bouncing) {
      return;
    }
    // checks if the ball and the racket overlap
    if (dist(x, y, racket.racX, racket.racY) < racket.racSize/2 - 5) {
      // the bouncing is true so the ball will continou bouncing and adds 1 to the score
      bouncing = true;
      score ++;
      return;
    } else {
      //println("Falling!");
      bouncing = false;
    }
  }

// is called in each frame by the main program and it displays the magic, the ball and the score
  void display () {
    fill (ballColor);
    ellipse(x, y, size + growth, size + growth);
    textAlign (CENTER);

    fill(#ffffff);
    text (score, width/2, height - 50);
  }
 // resets the ball and the size and the score
  void reset() {
    growth = 0;
    bouncing = true;
    score = 0;
  }
}