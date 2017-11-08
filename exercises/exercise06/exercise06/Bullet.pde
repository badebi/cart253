// Bouncer
//
// A class that defines a bullet that can change it size , so it seems as if it's approaching your image
// and if you stp it, after a couple of seconds, it falls on the ground

class Bullet {

  // Variables for position
  float x;
  float y;

  // Variables for velocity
  float vx;
  float vy;

  // The size of the Bouncer
  float size;

  // The current fill colour of the Bouncer
  color fillColor;

  // The default fill colour of the Bouncer
  color defaultColor;
  
  float time = 0;

  // Bouncer(tempX,tempY,tempVX,tempVY,tempSize,tempDefaultColor)
  //
  // Creates a Bouncer with the provided values by remembering them.

  Bullet(float tempX, float tempY, float tempVY, float tempSize, color tempDefaultColor) {
    x = tempX;
    y = tempY;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    fillColor = defaultColor;
  }

  // update()
  //
  // Adds the Bouncer's current velocity to its position
  // and checks for bouncing off the walls.
  void update(boolean tempHandIsUp) {
    
    if (tempHandIsUp && size <= 45) {
      size = 45;
      time += 0.1;
    }
    else {
      size -= 3;
      time = 0;
    }
    if (time >= 7){
      float gravity = 0.98;
      y = y + vy;
      vy = vy + gravity;
    }
    handleSize();
  }

 
  void handleSize() {
    if (size <= 1){
      size = random(100, 200);
      //x = random(0, width);
      y = random(0, height);
      vy = 1;
    }
  }
  

  // display()
  //
  // Draw an ellipse in the Bouncer's location, with its size
  // and with its fill
  void display() {
    
    stroke(0,floor(random(25,60)),0);
    fill(fillColor);
    ellipse(x, y, size, size);
  }
}