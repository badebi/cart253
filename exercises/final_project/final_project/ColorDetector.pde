//_________________________________________________________________________________properties

class ColorDetector {
  float record;
  float r;
  float g;
  float b;
  boolean sensitivity;
  // A PVector allows us to store an x and y location in a single object
  // When we create it we give it the starting x and y (which I'm setting to -1, -1
  // as a default value)
  PVector brightestPixel = new PVector(-1, -1);
  String colorToDetect;
  String displayType;
  boolean display;

  float lerpX;
  float lerpY;

  int threshold;

  //_________________________________________________________________________________ ColorDetector

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
    sensitivity = false;
  }

  //_________________________________________________________________________________

  void detect () {
    if (blueDetector.lerpY < height / 3 || redDetector.lerpY > blueDetector.lerpY ) {
      playerIsHidden = true;
    } else {
      playerIsHidden = false;
    }

    record = 1000;

    // Go through every pixel in the grid of pixels made by this
    // frame of video
    for (int x = 0; x < video.width; x++) {
      for (int y = 0; y < video.height; y++) {
        // Calculate the location in the 1D pixels array
        int loc = x + y * width;
        // Get the color of the pixel we're looking at
        color pixelColor = video.pixels[loc];
        // Get the blueest of the pixel we're looking at an stores it's location


        float difAmount = dist(r, g, b, red(pixelColor), green(pixelColor), blue(pixelColor));

        if (colorToDetect == "red") {
          sensitivity = red(pixelColor) > threshold && green(pixelColor) < 50 && blue(pixelColor) < 50 && difAmount < record;
        } else if (colorToDetect == "blue") {
          sensitivity = red(pixelColor) < 50 && green(pixelColor) < 50 && blue(pixelColor) > threshold && difAmount < record;
        } else if (colorToDetect == "green") {
          sensitivity = red(pixelColor) < 50 && green(pixelColor) > threshold && blue(pixelColor) < 50 && difAmount < record;
        }

        // this if for the accuracy of the blue detection! 
        // again, now because of my room's shitty lighting, I reduced the accuracy a bit ...
        // fill free to adjust the sensitivity according your room's lighting condition.
        if (sensitivity) {
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

    lerpX = lerp(lerpX, brightestPixel.x, 0.1);
    lerpY = lerp(lerpY, brightestPixel.y, 0.1);

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

  //_________________________________________________________________________________

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