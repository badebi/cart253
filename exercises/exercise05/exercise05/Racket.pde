// A class that defines a racket which can be moved by mouse
class Racket{
 int racSize;
 int racX;
 int racY;
 color racColor;
 // The constructor sets the variable to their starting values
  Racket (){
    racSize = 250;
    racColor = (#ff0000);
    racX = width/2;
    racY = height/2;
  }
  
  // displays the racket and updates it
void display(){
  fill(racColor);
  ellipse (racX,racY,racSize,racSize);
    racX = mouseX;
    racY = mouseY;
}
}