//first of all I should say that my English is bullshit and the only thing I'm good at is swearing... so I thank you beforehand for your effort you put to understand this shit! 

//in this part we defined some variables and we gave them a certain value which
//can not be changed throughout the program... why ? because we used the "final" keyword to define our variables

final int CIRCLE_SPEED = 7;
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;

//Defining variables for our circle coordinates (x and y) and it's speed in both directions!
int circleX;
int circleY;
int circleVX;
int circleVY;

void setup() {
  //Set the size of the window
  size(640, 480);
  //So first circle will be in the center of the window
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  //line around the shapes with the color we've defined on "STROKE_COLOR"
  stroke(STROKE_COLOR);
  //The initial fill color of the shapes
  fill(NO_CLICK_FILL_COLOR);
  //Sets the background color
  background(BACKGROUND_COLOR);
}

void draw() {
  // in short, if the mouse is in the circle, change its color to somthing bluish!
  
  //dist ---> it gives the distance between two points and it obviously needs x1,y1 & x2,y2.
  if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) { 
      fill(CLICK_FILL_COLOR);
  }
  // otherwise don't change the color or return it to its defult color which is the value of NO_CLICK_FILL_COLOR !
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  //draws a circle in each loop
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE); 
  // changes the value of circleX and adds the value of circleVX to it, so after each loop the X position of circle's center changes and creats the illusion of movement!
  circleX += circleVX;
  // changes the value of circleY and adds the value of circleVY to it, so after each loop the Y position of circle's center changes and creats the illusion of movement!
  circleY += circleVY; 
  
  //these ifs are here to bounce the circle back to the frame, so the circle doesn't leave the frame.
  //The circle won't leave the window from left or right
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  //The circle won't leave the window from top or bottom
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}

//This functionis called when the mouse botton goes down and it's gonna fill the window with background color 
//as if we erase all the shit ! 
void mousePressed() {
  background(BACKGROUND_COLOR);
}