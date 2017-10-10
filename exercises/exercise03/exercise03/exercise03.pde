//Exercise 03 code

// Basically this program shows two balls, red and blue, which move symmetrically inside the window.
// (you can see the trace of their movement as well)
// And if you hover the mouse one each ball, their color is gonna change

color backgroundColor = color(200,150,150);
// Defining 2 variables of the type "Bouncer", which is a class
Bouncer bouncer;
Bouncer bouncer2;

void setup() {
  size(640,480);
  background(backgroundColor);
  // Making 2 new objects by calling the "Bouncer" constructor; with different characteristics.
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(150,0,0,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(0,0,150,50),color(0,0,255,50));
}

void draw() {
  // it displays the bouncers, those we've defined in the setup, (by calling draw method of each object)
  // and it displays their movement (by calling update method of each object)
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}

void mouseClicked(){
  bouncer.mouseClicked();
  bouncer2.mouseClicked();
}