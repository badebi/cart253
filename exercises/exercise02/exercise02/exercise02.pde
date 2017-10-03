// Generally it's kind of one player Pong game that ball is bouncing around and you should keep it in the screen using the paddle.

color backgroundColor = color(0);

int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);

// Sets up the the existance of everything we need. 
// We've used differenet setups for different elements so the program is much easier to read and more organized
void setup() {
  size(640, 480);
  
  setupPaddle();
  setupBall();
}

void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  // So in the beginning the paddle doesn't move.
  paddleVX = 0;
}

void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

// Draws the the ball, Paddle and background effects and updates them each frame.
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

// when it's called, draws 1000 random squares with random sizes (either 1, 2 r 3 pixles) in a frame
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}

// to change the position of the paddle and make it move
void updatePaddle() {
  paddleX += paddleVX;
  // It limits the Paddles movement inside the window 
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

// to make the ball move and limits it's movement within the window and makes it reset from the center when it goes off screen from the bottom
// we do these things by defining different functions.
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

// Draws th paddle
void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

// Draws the Ball
void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

// it makes the ball bounce when it touches the paddle
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    // to have a good looking bounce from the paddle
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
  }
}

// To know if the Ball and the Paddle overlap or not and it returns true or false
boolean ballOverlapsPaddle() {
  // it sees if the ball is on the top of the paddle
  //(in the other words, it sees if the ball is in the same range of X's that the paddle covers at the moment)
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    // Then it checks if the ball's Y is in the range of the Y's that the paddle covers or not 
    // Which means they're literally overlappin eachother
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

// It resets the balls posistion and places it in center of the window when it goes off from the bottom
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}

// to check if the ball goes off the screen from the bottom or not and it returns true or false
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

// To limit the ball's movement inside the window and makes it bounce back inside from the sides and the top
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}

// it's called when a key is pressed and it gives us the ablity to control the paddle
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

// it's called when a key is released and it stops the paddle
void keyReleased() {
  // you may ask why didn't we just put "paddleVX=0" instead of these if statements
  // I shall say that these if statements are making the gameplay more enjoyable and makes it much more smoother
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}