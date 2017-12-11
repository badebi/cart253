class Animation {
  PImage newspaper;

  float newsPaperY;
  float lerpNPY;
  boolean poorGuyIsShocked;

  int counter = 0;

  // How fast the avatar mores (pixels per second)
  float avatarSpeed; 
  float avatarSize;
  
  float micThreshold;


  Animation() {
    micThreshold = 0.3;
    newspaper = loadImage ("newspaper2.png");
    newsPaperY = 580;
    lerpNPY = 0;
    poorGuyIsShocked = false;
    avatarSpeed = 50;
    avatarSize = 1;
    // Set the avatar's position on screen
    background.setXY(width/2, height/2);
    avatar.setXY(width/2, height/2);
    // Set the default (idle) frame sequence from the
    // sheet to animate
    //avatar.setFrameSequence(1, 1);
  }

  void handleAnimation() {

    // Sprites library stuff!
    // We get the time elapsed since the last frame (the deltaTime)
    double deltaTime = timer.getElapsedTime();
    // We update the sprites in the program based on that delta
    S4P.updateSprites(deltaTime);
    // Then we draw them on the screen
    S4P.drawSprites();

    // Get the current level (volume) going into the microphone
    float level = mic.mix.level();
   
    background.setFrameSequence(0, 11, 0.25);
    avatar.setFrameSequence(0, 0);

    // If the avatar goes off the left or right
    // wrap it around
    if (avatar.getX() > width) {
      avatar.setX(avatar.getX() - width);
    } else if (avatar.getX() < 0) {
      avatar.setX(avatar.getX() + width);
    }

    avatar.setVelXY (-100, 0);


    image (newspaper, width/2, lerpNPY );
    newsPaperY = 300 + blueDetector.brightestPixel.y;
    lerpNPY = lerp(lerpNPY, newsPaperY, 0.1);

    //float velX = map(level,0 , 0.5, -100, 0);

    //if (level > 0.06) {
    // avatar.setVelXY (velX, 0);
    //}
    if (level > micThreshold && !playerIsHidden) { 
      poorGuyIsShocked = true;
    }
    if (poorGuyIsShocked) {
      avatar.setVelXY (0, 0);
      counter ++;
      if (counter > 120) {
        avatar.setScale (avatarSize) ;
        avatar.setFrameSequence(1, 1);
        avatarSize = avatarSize + 0.1 ;
        avatarSize = constrain(avatarSize, 1, 6);

        newsPaperY += 5;
        newsPaperY = constrain(newsPaperY, 580, 780);
      }
    }
  }
  
  void keyPressed(){
    if (keyCode == LEFT){
      micThreshold -= 0.05;
    } else if (keyCode == RIGHT){
      micThreshold += 0.05;
    }
    println("Mic Threshold =" + micThreshold);
  }
}