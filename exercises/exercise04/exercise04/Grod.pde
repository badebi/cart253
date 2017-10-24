// Grod
//
// A class defining the behaviour of a single Grod
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Grod
// and becomes extremely happy by meeting a Griddie

class Grod {
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
  color fill = color(0, 0, 255);

  // Grod(tempX, tempY, tempSize)
  //
  // Set up the Grod with the specified location and size
  // Initialise energy to the maximum
  Grod (int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Grod and update its energy levels
  void update() {

    // if the energy of the a Grod is zero, so it breaks out of update() skipping the lines after
    // so it dies and it's not gonna come back again
    if (energy == 0) {
      return;
    }

    // if we imagin a square 3 times bigger than a Grod, and we devide it to 9 equal squares (which gives us
    // 9 square as same size as a Grod), and we imagin our Grod as the center square in this imaginary square,
    // the Grod's next position in the next frame will be one of these 9 squares.
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // they prevent the Grods to get of the frame and disappear, so they bring them back
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

    // Update the Grod's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Grods energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Grod
  // and updates energy level

  void collide(Grod other) {
    // if both of the Grods are dead, it breaks out of collide(other) and it won't
    // check if they collide or not ... so they will stay dead
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // it checks if both of the Grods are in the same section of the grid (if they overlap)
    if (x == other.x && y == other.y) {
      // Increase this Grod's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  //
  void collide(Griddie other) {
    // if both of the griddie and the Grod are dead, it breaks out of collide(Griddie other) and it won't
    // check if they collide or not ... so they will stay dead
    if (energy == 0 || other.energy == 0) {
      return;
    }

    // it checks if the Grod and the griddie are in the same section of the grid (if they overlap)
    if (x == other.x && y == other.y) {
      // if the grod and the griddie have enough energy, they will have fun for a moment,
      // their energy becomes full and they color will change so we can say that they got married
      if ((4*maxEnergy/5 < energy && energy < maxEnergy) || (4*maxEnergy/5 < other.energy && other.energy < maxEnergy)) {
        // Increase their energy
        energy += collideEnergy;
        other.energy += collideEnergy;

        // make them stop and let them enjoy their time
        xMoveType = 0;
        yMoveType = 0;
        other.xMoveType = 0;
        other.yMoveType = 0;
      } else if (energy == maxEnergy && other.energy == maxEnergy) {
        // they will finish their thing, they become purple and they continue their random movement
        fill = color(200, 0, 255);
        other.fill = color(255, 0, 200);
      }

      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Grod on the screen as a rectangle
  void display() {
    // gives the grod a color which is "fill", and oppacity which represents its energy
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}