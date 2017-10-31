float theta = 0;
int initialSize = 200;


Ball ball;
Racket racket;

void setup() {
  size(600,600);
  background(0);
  
  ball = new Ball (width/2,height/2,initialSize);
  racket = new Racket ();
}
void draw() {
  background(0);
  racket.display();
  ball.update();
  ball.display();
  
}