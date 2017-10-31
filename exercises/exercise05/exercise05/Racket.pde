class Racket{
 int racSize;
 int racX;
 int racY;
 color racColor;
  Racket (){
    racSize = 250;
    racColor = (#ff0000);
    racX = width/2;
    racY = height/2;
  }
void update(){

}
void display(){
  fill(racColor);
  ellipse (racX,racY,racSize,racSize);
    racX = mouseX;
    racY = mouseY;
}
}