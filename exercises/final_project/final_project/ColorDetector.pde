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
  boolean display;

  ColorDetector (String _colorToDetect, boolean _display) {
    colorToDetect = _colorToDetect;
    display = _display;
    r = 0;
    g = 0;
    b = 0;

    sensitivity = false;
  }

  void detect () {
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


        float difAmount = 0;
        if (colorToDetect == "red") {
          r = 255;
          g = 0;
          b = 0;
          difAmount = dist(r, g, b, red(pixelColor), green(pixelColor), blue(pixelColor));
          sensitivity = red(pixelColor) > 75 && green(pixelColor) < 50 && blue(pixelColor) < 50 && difAmount < record;
        }
        else if (colorToDetect == "blue") {
          r = 0;
          g = 0;
          b = 255;
          difAmount = dist(r, g, b, red(pixelColor), green(pixelColor), blue(pixelColor));
          sensitivity = red(pixelColor) < 50 && green(pixelColor) < 50 && blue(pixelColor) > 75 && difAmount < record;
        }
        else if (colorToDetect == "green") {
          r = 0;
          g = 255;
          b = 0;   
          difAmount = dist(r, g, b, red(pixelColor), green(pixelColor), blue(pixelColor));
          sensitivity = red(pixelColor) < 50 && green(pixelColor) > 100 && blue(pixelColor) < 50 && difAmount < record;
        }

        // this if for the accuracy of the blue detection! 
        // again, now because of my room's shitty lighting, I reduced the accuracy a bit ...
        // fill free to adjust the sensitivity according your room's lighting condition.
        if (sensitivity) {
          record = difAmount;
          brightestPixel.x = width - x;
          brightestPixel.y = y;
        }
      }
    }
  }

  void display() {
    if (display) {
      // For now we just draw a crappy ellipse at the reddest pixel
      fill(r, g, b);
      stroke(#ffff00);
      strokeWeight(3);
      ellipse(brightestPixel.x, brightestPixel.y, 20, 20);
    }
  }
}