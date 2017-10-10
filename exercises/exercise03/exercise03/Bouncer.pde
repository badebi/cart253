// Defining the Class
class Bouncer {

  // Defining the properties of the class Bouncer.
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
 // here is the setup() for the Bouncer which is the constructor.
 // it happens once each time we call new Bouncer and we create ne object.
 // as you see, it needs some inputs (Arguments) for setting up each object which are 
 // initial coordinates of the object, its velocity in each direction, its size and default color
 // and aslo the color you want when you hover the mouse over it
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   // so it puts the arguments into the properties, hence an object get defined
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 // this method makes the object move and tells him how to behave in different situations,
 // such as when the object reachs to the edge of the window or when the mouse hover over it
 void update() {
   x += vx;
   y += vy;
   
   handleBounce();
   handleMouse();
 }
 
 // It bounces the object back to the frame when it intends to exit the frame
 void handleBounce() {
   // makes the object bounce from the sides
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
   }

   // makes the object bounce from the top and the bottom
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
   }
   
   // Basically it give us a good looking bounce by limiting the objects position
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 // it's gonna change the objects color whenever the mouse coordinates are somewhere inside the object. 
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   // Changes the color back to the default color when the mouse is not over the object
   else {
     fillColor = defaultColor;
   }
 }
 
 // Displays the bouncer
 void draw() {
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}