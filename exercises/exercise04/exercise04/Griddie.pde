// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.

class Griddie {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;

  int xMoveType;
  int yMoveType;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255, 0, 0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {

    // QUESTION: What is this if-statement for?
    // ANSWER: if the energy of the a griddie is zero, so it breaks out of update() skipping the lines after
    // so unfortunately it dies and it's not gonna come back again
    if (energy == 0) {
      return;
    }

    // QUESTION: How does the Griddie movement updating work?
    // ANSWER: if we imagin a square 3 times bigger than a griddie, and we devide it to 9 equal squares (which gives us
    // 9 square as same size as a griddie), and we imagin our griddie as the center square in this imaginary square,
    // the griddie's next position in the next frame will be on of the other squares around it.
    //
    // I hope you get what I was trying to say :D
    xMoveType = floor(random(-1, 2));
    yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;



    // QUESTION: What are these if statements doing?
    // ANSWER : they prevent the griddies to get of the frame and disappear, so they bring them back
    // from the opposite side of the frame
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level

  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    // ANSWER: if both of the griddie are dead, it breaks out of collide(Griddie other) and it won't
    // check if they collide or not ... so they will stay dead
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // QUESTION: What does this if-statement check?
    // ANSWER: it checks if both of the griddies are in the same section of the grid (if they overlap)
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    // ANSWER; gives the griddie a color which is "fill", and oppacity which represents its energy
    fill(fill, energy); 
    noStroke();
    ellipse(x, y, size, size);
  }
}