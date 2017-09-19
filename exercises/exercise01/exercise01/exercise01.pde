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
  size(640, 480); 
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);
  background(BACKGROUND_COLOR);
}

void draw() {
  // in short, if the mouse is in the circle, change its color to somthing bluish!  
  if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) { 
      fill(CLICK_FILL_COLOR);
  }
  // otherwise don't change the color or return it to its defult color which is the value of NO_CLICK_FILL_COLOR !
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE); //draws a circle in each loop
  circleX += circleVX; // changes the value of circleX and adds the value of circleVX to it, so after each loop the X position of circle's center changes and creats the illusion of movement!
  circleY += circleVY; // changes the value of circleY and adds the value of circleVY to it, so after each loop the Y position of circle's center changes and creats the illusion of movement!
  
  //these ifs are to bounce the circle back to the frame 
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}

void mousePressed() {
  background(BACKGROUND_COLOR);
}