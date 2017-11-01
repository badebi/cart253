// declaring and initializing The size of the ball
int initialSize = 200;

// global variables for ball and racket
Ball ball;
Racket racket;

// sets up the window size  and background color 
// and creats the ball and the racket
void setup() {
  size(600,600);
  background(0);
  
  ball = new Ball (width/2,height/2,initialSize);
  racket = new Racket ();
}

// handles all the magic which is a baal bounces on a racket
// each frame it calls the display method of each class and the update method of the ball
void draw() {
  background(0);
  racket.display();
  ball.update();
  ball.display();
  
}

// if mouse pressed the ball will reset and score turns to zero
void mousePressed(){
  ball.reset();
}