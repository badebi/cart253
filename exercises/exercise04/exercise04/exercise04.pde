// Griddies
// by Pippin Barr
// MODIFIED BY: 
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;
// An array storing all the griddies
Griddie[] griddies = new Griddie[100];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  // ANSWER: it creates a set of griddies (in this case 100 of them) (instantiates multiple griddies if I say it
  // correctly) and place them in the random place in the different grids based on th gridSize)
  for (int i = 0; i < griddies.length; i++) {
    // it devids the window to grides and we will have random coordinates for a specific square each time
    //to place oue griddie in it
    int x = floor(random(0, width/gridSize));
    int y = floor(random(0, height/gridSize));
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      // ANSWER: because we don't want to check a gridie with itself to see if they collide,
      // by using this if statement we make sure that we won't do that
      if (j != i) {
        // QUESTION: What does this line check?
        // ANSWER: it checks the griddie in the index "i" with all other griddies to see if they collide or not 
        griddies[i].collide(griddies[j]);
      }
    }
    
    // Display the griddies
    griddies[i].display();
  }
}