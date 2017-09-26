//first of all I should say that my English is bullshit and the only thing I'm good at is swearing... so I thank you beforehand for your effort you put to understand this shit! 

//in this part we defined some variables and we gave them a certain value which
//can not be changed throughout the program... why ? because we used the "final" keyword to define our variables

final int CIRCLE_SPEED = 5; //CHANGED because I didn't like it
final color NO_CLICK_FILL_COLOR = color(69, 69, 69); //CHANGED because I didn't like it
final color CLICK_FILL_COLOR = color(85, 107, 47); //CHANGED because I didn't like it


final color BACKGROUND_COLOR = color(255, 255, 255); //CHANGED because I didn't like it
final color STROKE_COLOR = color(42, 42, 42); //CHANGED because I didn't like it
final int CIRCLE_SIZE = 50;

//Defining variables for our circle coordinates (x and y) and it's speed in both directions!
int circleX;
int circleY;
int circleVX;
int circleVY;

//CHANGED 
int currentCircleSize; //the circle size is gonna change
int nextCircleX; //to store the next circle's X position
int nextCircleY; //to store the next circle's Y position

void setup() {
  //Set the size of the window
  size(640, 480);
  //So first circle will be in the center of the window
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  currentCircleSize = CIRCLE_SIZE;
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
  if (dist(mouseX, mouseY, circleX, circleY) < currentCircleSize/2) { //CHANGED CIRCLE_SIZED is replaced by currentCircleSize
    fill(CLICK_FILL_COLOR);
  }
  // otherwise don't change the color or return it to its defult color which is the value of NO_CLICK_FILL_COLOR !
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  //draws a circle in each loop
  ellipse(circleX, circleY, currentCircleSize, currentCircleSize); //CHANGED CIRCLE_SIZED is replaced by currentCircleSize
  // changes the value of circleX and adds the value of circleVX to it, so after each loop the X position of circle's center changes and creats the illusion of movement!
  circleX += circleVX;
  // changes the value of circleY and adds the value of circleVY to it, so after each loop the Y position of circle's center changes and creats the illusion of movement!
  circleY += circleVY; 

  //these ifs are here to bounce the circle back to the frame, so the circle doesn't leave the frame.
  //The circle won't leave the window from left or right
  if (circleX + currentCircleSize/2 > width || circleX - currentCircleSize/2 < 0) { //CHANGED CIRCLE_SIZED is replaced by currentCircleSize
    circleVX = -circleVX;
  }
  //The circle won't leave the window from top or bottom
  if (circleY + currentCircleSize/2 > height || circleY - currentCircleSize/2 < 0) { //CHANGED CIRCLE_SIZED is replaced by currentCircleSize
    circleVY = -circleVY;
  }

  //CHANGED to know the posision of next circle
  nextCircleX = circleX + circleVX;
  nextCircleY = circleY + circleVY;
  //CHANGED to know if the circle is in a certain zone
  if (dist(mouseX, mouseY, circleX, circleY) < 2.5 * CIRCLE_SIZE) {
    //CHANGED if the circle is getting closer to the mouse, it gets bigger
    if (dist(mouseX, mouseY, circleX, circleY) > dist(mouseX, mouseY, nextCircleX, nextCircleY)) {
      currentCircleSize = constrain(currentCircleSize+1, 10, 80);
    } 
    //CHANGED if the circle is getting farther fram the mouse, it gets smaller
    else  {
      currentCircleSize = constrain(currentCircleSize-1, 10, 80);
    }
  } 
  
  //DON'T READ THESE...
  //if (dist(mouseX, mouseY, circleX, circleY) > dist(mouseX, mouseY, nextCircleX, nextCircleY))
  //else {
  //  currentCircleSize = CIRCLE_SIZE;
  //}
}

//This functionis called when the mouse botton goes down and it's gonna fill the window with background color 
//as if we erase all the shit ! 
void mousePressed() {
  background(BACKGROUND_COLOR);
}