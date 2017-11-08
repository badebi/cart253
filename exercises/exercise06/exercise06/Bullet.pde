// Bullet
//
// A class that defines a bullet that can change it size , so it seems as if it's approaching your image
// and if you stop it, after a couple of seconds, it falls on the ground

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
  
  // The time passed after the bullet has stoped
  float time = 0;

  // Bullet(tempX,tempY,tempVY,tempSize,tempDefaultColor)
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
  // changes the size of the bullet so we think it's going towards our image
  // it also checks if the bullet has stoped by the player for couple of seconds, if yes
  // it will makee the bullet fall down
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

 // makes the firing continous and also it resets the pall position when it falls
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
  // Draw an ellipse in the Bullet's location, with its size
  // and with its fill and stroke
  void display() {
    
    stroke(0,floor(random(25,60)),0);
    fill(fillColor);
    ellipse(x, y, size, size);
  }
}