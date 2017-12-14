// ColorDetector
//
// The class that gives you the ability to detect colors (for this game red, green and blue)
// It also checks if the player is hidden or not 
// The thresholds for each color to detect is adjustable through settings in the game (with
// UP and DOWN arrow kes, and the SHIFT key to change between the colors), also by pressing 
// SPACE bar during the game, you can make the guides visible and adjust them with same keys.

//_________________________________________________________________________________PROPERTIES

class ColorDetector {
  // to keep the record of the most colorfull pixel (brightest pixel) found
  float record;
  // storing RGB values
  float r;
  float g;
  float b;
  // To see if the pixel is the brightest pixel (in the specific color) there is or not
  boolean isBrightest;
  // A PVector allows us to store an x and y location in a single object
  // When we create it we give it the starting x and y (which I'm setting to -1, -1
  // as a default value)
  PVector brightestPixel = new PVector(-1, -1);
  // The know what color to track
  String colorToDetect;
  // Either line or ellipse 
  String displayType;
  // Display the guides or not?
  boolean display;
  // to make the detection more smoother
  float lerpX;
  float lerpY;
  // the sensitivity
  int threshold;

  //_________________________________________________________________________________CONSTRUCTOR

  // ColorDetector (String _detectColor, boolean _display, String _displayType)
  //
  // It gets 3 arguments from the main program: _detectColor, in this case either "red", "green"
  // or "blue", _display to show or not to show the guides on screen and  _displayType which  
  // would be either "line" or "ellipse".
  // Then it initialize the properties based on them.

  ColorDetector (String _detectColor, boolean _display, String _displayType) {
    colorToDetect = _detectColor;
    display = _display;
    displayType = _displayType;
    lerpX = 0;
    lerpY = 0;
    threshold = 80;
    if (_detectColor == "red") {
      r = 255;
      g = 0;
      b = 0;
    }
    if (_detectColor == "green") {
      r = 0;
      g = 255;
      b = 0;
    }
    if (_detectColor == "blue") {
      r = 0;
      g = 0;
      b = 255;
    }
    isBrightest = false;
  }

  //_________________________________________________________________________________detect()

  // void detect()
  //
  // each frame, it goes through the all pixels of that frame of the video and looks for the
  // brightest pixel of specific color.

  void detect() {
    if (blueDetector.lerpY < height / 3 || redDetector.lerpY > blueDetector.lerpY ) {
      playerIsHidden = true;
    } else {
      playerIsHidden = false;
    }

    record = 1000;

    // Go through every pixel in the grid of pixels made by this frame of video
    for (int x = 0; x < video.width; x++) {
      for (int y = 0; y < video.height; y++) {
        // Calculate the location in the 1D pixels array
        int loc = x + y * width;
        // Get the color of the pixel we're looking at
        color pixelColor = video.pixels[loc];

        float difAmount = dist(r, g, b, red(pixelColor), green(pixelColor), blue(pixelColor));

        // check the color difference for each color that you can detect (red, green, and blue)
        // then store the location of the brightest pixel of that color in the brightestPixel
        // treshold is changable in the setting, so you can change the accuracy of the detection.

        if (colorToDetect == "red") {
          isBrightest = red(pixelColor) > threshold && green(pixelColor) < 50 && blue(pixelColor) < 50 && difAmount < record;
        } else if (colorToDetect == "blue") {
          isBrightest = red(pixelColor) < 50 && green(pixelColor) < 50 && blue(pixelColor) > threshold && difAmount < record;
        } else if (colorToDetect == "green") {
          isBrightest = red(pixelColor) < 50 && green(pixelColor) > threshold && blue(pixelColor) < 50 && difAmount < record;
        }

        // Store its location and show them on screen with small points (if display is true)
        if (isBrightest) {
          if (display) {
            stroke(r, g, b);
            strokeWeight(3);
            point(width - x, y);
          }
          record = difAmount;
          brightestPixel.x = width - x;
          brightestPixel.y = y;
        }
      }
    }

    // make things smooth like butter
    lerpX = lerp(lerpX, brightestPixel.x, 0.1);
    lerpY = lerp(lerpY, brightestPixel.y, 0.1);

    // if display is true, show the guide lines (ellipses) on the screen
    if (display) {
      // For now we just draw a crappy ellipse at the reddest pixel
      stroke(r, g, b);
      strokeWeight(3);
      fill(r, g, b);
      if (displayType == "line") {
        line(0, lerpY, width, lerpY);
      } else if (displayType == "ellipse") {
        ellipse(lerpX, lerpY, 20, 20);
      }
    }
  }

  //_________________________________________________________________________________void keyPressed()

// void keyPressed()
//
// It's called by keyPressed() in the main program, if the game is in the setting stage or display's
// value is true

  void keyPressed() {
    if (keyCode == DOWN) {
      threshold --;
      //println(threshold);
    }
    if (keyCode == UP) {
      threshold ++;
      //println(threshold);
    }
  }
}