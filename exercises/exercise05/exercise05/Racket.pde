class Racket{
 int racSize;
 int racX;
 int racY;
 color racColor;
  Racket (){
    racSize = 250;
    racColor = (#ff0000);
    racX = mouseX;
    racY = mouseY;
  }
void update(){

}
void display(){
  fill(racColor);
  ellipse (racX,racY,racSize,racSize);
}
}