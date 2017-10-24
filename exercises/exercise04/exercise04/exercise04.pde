// Griddies
// by Pippin Barr
// MODIFIED BY: Ebrahim Badawi
//
// A simple artificial life system on a grid. The "griddies" are circles that move
// around randomly, and the "Grods" are square that do the same thing, 
// using energy to do so. They gain energy by overlapping with themselves. an if they have
// enough energy, they will be able to make out with the other kind and gain the max energy possible
// If a griddie or a grod loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
// two arrays storing all the griddies and grods
Griddie[] griddies = new Griddie[50];
Grod[] grods = new Grod[50];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  // ANSWER: it creates a set of griddies (in this case 50 of them) (instantiates multiple griddies if I say it
  // correctly) and place them in the random places in the different grids based on th gridSize)
  //same thing for Grods afterwards
  for (int i = 0; i < griddies.length; i++) {
    // it devides the window to grides and we will have random coordinates for a specific square each time
    // to place our griddie in it
    //same thing for grods afterwards
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }

  for (int j = 0; j < grods.length; j++) {
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    grods[j] = new Grod (x * gridSize, y * gridSize, gridSize);
  }
}

// draw()
//
// Update all the griddies and grods, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // because we don't want to check a griddie with itself to see if they collide,
      // by using this if statement we make sure that we won't do that
      if (j != i) {
        // it checks the griddie in the index "i" with all other griddies to see if they collide or not 
        griddies[i].collide(griddies[j]);
      }
    }
    // Display the griddies
    griddies[i].display();
  }


  // We do the same thing for Grods
  for (int k = 0; k < grods.length; k++) {

    grods[k].update();

    for (int l = 0; l < grods.length; l++) {

      if (l != k) {
        grods[k].collide(grods[l]);
      }
    }
    // this time we check if a grod collides with a griddie or not
    for (int m = 0; m < griddies.length; m++) {
      grods[k].collide(griddies[m]);
    }
    grods[k].display();
  }
}