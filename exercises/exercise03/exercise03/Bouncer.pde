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

  //CHANGED I defined a Property for the oppacity of the objects
  float oppacity;
  //CHANGED I defined a property to make the objec's size variable
  int varSize;
  //CHANGED so I can store the initial value of the speed 
  int conVX;
  int conVY;

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

    oppacity = 100;//CHANGED I gave it an initial value
    varSize = tempSize; //CHANGED I gave it an initial value

    conVX = tempVX; //CHANGED I gave it an initial value
    conVY = tempVY; //CHANGED I gave it an initial value
  }

  // this method makes the object move and tells him how to behave in different situations,
  // such as when the object reachs to the edge of the window or when the mouse hover over it
  void update() {
    x += vx;
    y += vy;

    handleBounce();
    handleMouse();
    handleSize(); //CHANGED I defined this method to control the size of the object
  }

  // It bounces the object back to the frame when it intends to exit the frame
  void handleBounce() {
    // makes the object bounce from the sides
    if (x - varSize/2 < 0 || x + varSize/2 > width) {//CHANGED size is replaced with varSize 
      vx = -vx;

      conVX *= -1;
      oppacity = 10; //CHANGED so whenever bouncer hits the wall its oppacity gonna turn to 10 and it's gonna start raising after it bounces
    }

    // makes the object bounce from the top and the bottom
    if (y - varSize/2 < 0 || y + varSize/2 > height) {//CHANGED size is replaced with varSize 
      vy = -vy;

      conVY *= -1;
      oppacity = 10; //CHANGED again, whenever bouncer hits the wall its oppacity gonna turn to 10 and it's gonna start raising after it bounces
    }

    // Basically it give us a good looking bounce by limiting the objects position
    x = constrain(x, varSize/2, width-varSize/2);//CHANGED size is replaced with varSize 
    y = constrain(y, varSize/2, height-varSize/2);//CHANGED size is replaced with varSize 

    //CHANGED here where the value of oppacity raises
    oppacity += 0.9; //CHANGED
    oppacity = constrain(oppacity, 10, 100); //CHANGED
  }

  // it's gonna change the objects color whenever the mouse coordinates are somewhere inside the object. 
  void handleMouse() {
    if (dist(mouseX, mouseY, x, y) < varSize/2) { //CHANGED size is replaced with varSize 
      fillColor = hoverColor;
    }
    // Changes the color back to the default color when the mouse is not over the object
    else {
      fillColor = defaultColor;
    }

    //CHANGED I added a conditional which can change the position of the objects
    //Basically, when the mouse is pressed, then it's gonna stop the object and you can change their position by moving the mouse
    if (mousePressed) {
      vx=0;
      vy=0;
      x = x + (mouseX - pmouseX);
      y = y + (mouseY - pmouseY);
    }
  }

  // Displays the bouncer
  void draw() {
    noStroke();
    fill(fillColor, oppacity); //CHANGED I added the variable oppacity to the fill
    ellipse(x, y, varSize, varSize); //CHANGED
  }


  //CHANGED by clicking the mouse, the size of the objects are gonna increase 
  void mouseClicked() {
    varSize = varSize + (varSize/3);
    varSize = constrain(varSize, size, 3*size);
  } 

  //CHANGED the size of the object is gonna back to normal gradually
  void handleSize() {
    if (varSize > size) {
      varSize -= 1;
      varSize = constrain(varSize, size, 3*size);
    }
  }


  //CHANGED when you release the mouse, the objects are gonna continue their movement to the same direction they had before
  void mouseReleased() {
    vx=conVX;
    vy=conVY;
  }
}