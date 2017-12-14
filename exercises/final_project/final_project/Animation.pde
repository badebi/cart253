//_________________________________________________________________________________

class Animation {
  //PImage newspaper;

  float newspaperY;
  float lerpNY;
  boolean thatGuyIsShocked;

  int counter = 0;

  // How fast the avatar mores (pixels per second)
  float avatarSpeed; 
  float avatarSize;

  float micThreshold;



  float level;

  boolean isNewAvatar;

  float newAvatarX;
  float newAvatarY;

  float newspaperRestartY;

  float speedDifficulty = 0;

  float thatGuysSensitivity;

  float thatGuysPanicingTime = 0;

  boolean newspaperIsOpen = false;

  int alpha = 0;


  //_________________________________________________________________________________constructor

  Animation() {
    prvGameStage = null;
    gameStage = "menu";
    isNewAvatar = false;
    micThreshold = 0.35;
    newspaperY = 580;
    lerpNY = 0;
    thatGuyIsShocked = false;
    avatarSpeed = 50;
    avatarSize = 1;
    // Set the avatar's position on screen
    background.setXY(width/2, height/2);
    background.setFrameSequence(0, 11, 0.25);
  }

  //_________________________________________________________________________________handleAnimation()

  void handleAnimation() {
    //println(gameStage);

    spriteStuff();

    if (gameStage == "menu") {
      menu();
    }

    if (gameStage == "setting") {
      setting();
    }

    if (gameStage == "transition") {
      transition();
    } 

    if (gameStage == "gameover") {
      gameOver();
    } 

    if (gameStage == "restart") {
      reStart();
    }

    if (gameStage == "start") {
      startGame();
    }
  }

  //_________________________________________________________________________________menu()

  void menu() {

    avatar.setVisible(false);
    newspaperSprite.setVisible(true);
    newspaperSprite.setXY(width/2, height/2);
    if (newspaperSprite.getFrame() == 17) {
      level = mic.mix.level();
      newspaperSprite.stopImageAnim();
      score.displayHighScore();

      fill(0, 0, 255, alpha);
      alpha = (alpha + 11) % 255;
      textFont(myNiceShadedFont); // Use the new font
      textSize(16); // Font size
      textAlign(CENTER, CENTER); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      text("SettinG", 449, 449);


      if (level > micThreshold) {
        prvGameStage = "menu";
        gameStage = "transition";
        transition();
        return;
      }
    } else  if (prvGameStage == "setting") {
      newspaperSprite.setFrameSequence(33, 17, 0.1);
      return;
    } else if (prvGameStage != "restart") {
      newspaperSprite.setFrameSequence(0, 17, 0.1);
    }
  }

  //_________________________________________________________________________________setting()

  void setting() {    
    if (prvGameStage == "menu") {
      newspaperSprite.setFrameSequence(17, 35, 0.1);
      if (newspaperSprite.getFrame() == 34) {
        newspaperSprite.setFrame(35);
        prvGameStage = "setting";
      }
    } else {
      newspaperSprite.setFrame(settingPage);

      blueDetector.display = true;
      redDetector.display = true;

      fill(0, 0, 0, alpha);
      alpha = (alpha + 11) % 255;
      textFont(myNiceShadedFont); // Use the new font
      textSize(22); // Font size
      textAlign(CENTER, CENTER); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      text("MENU", 449, 449);



      textFont(myDopeFont); // Use the new font
      textSize(88); // Font size
      textAlign(CENTER, CENTER); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      if (settingPage == 35) {
        fill(0, 0, 255);
        text(blueDetector.threshold, 512, 340);
      } else if (settingPage == 36) {
        fill(255, 0, 0);
        text(redDetector.threshold, 512, 340);
      }
    }
  }

  //_________________________________________________________________________________transition()

  void transition() {
    avatarReset();
    blueDetector.display = false;
    redDetector.display = false;
    prvGameStage = "transition";
    gameStage = "start";
    return;
  }

  //_________________________________________________________________________________startGame()

  void startGame() {
    avatar.setVisible(true);
    if (!thatGuyIsShocked) {
      if (isNewAvatar) {
        handleNewAvatar();
      }

      // Get the current level (volume) going into the microphone

      handleNewspaper();
      if (newspaperIsOpen) {
        level = mic.mix.level();
      }

      if (level > thatGuysSensitivity && !playerIsHidden) {           
        goToPanicMode();
      }
    } else {
      handleNewspaper();
      goToPanicMode();
    }
  }

  //_________________________________________________________________________________goToPanicMode()

  void goToPanicMode() {
    thatGuyIsShocked = true;
    avatar.setVelXY (0, 0);
    avatar.setFrameSequence(4, 7, 0.2);
    counter ++;
    //println(counter);
    if (!playerIsHidden) {
      if (counter > thatGuysPanicingTime && !playerIsHidden) {
        gameOver();
        return;
      }
    } else {
      if (counter > thatGuysPanicingTime + 15) {
        score.addPoint();
        avatarReset();
      }
    }
  }

  //_________________________________________________________________________________gameOver()

  void gameOver() {
    prvGameStage = "start";
    gameStage = "gameover";
    level = mic.mix.level();

    fill(random(0, 255), random(0, 255), random(0, 255));
    textFont(myNiceShadedFont); // Use the new font
    textSize(64); // Font size
    textAlign(CENTER, CENTER); // Center align both horizontally and vertically
    textLeading(28); // Line height for text
    text("Game Over", width / 2, height / 2);

    avatar.setVelXY (0, 0);
    avatar.setScale (avatarSize) ;
    avatar.setFrameSequence(8, 9, 0.2);
    avatarSize = avatarSize + 0.2 ;
    avatarSize = constrain(avatarSize, 1, 6);

    goToCenter();

    lerpNY = lerp(lerpNY, newspaperY, 0.25);
    newspaperY = height/2 + blueDetector.brightestPixel.y;
    newspaperSprite.setY(lerpNY);
    newspaperY = constrain(newspaperY, 580, 780);
    newspaperRestartY = newspaperY;

    score.display();

    score.updateHighScore();

    if (level > micThreshold ) {
      prvGameStage = "gameover";
      gameStage = "restart";
    }
  }

  //_________________________________________________________________________________reStart()

  void reStart() {
    //don't get upset ... grab your newspaper and start over
    if (newspaperSprite.getFrame() > 25) {
      newspaperSprite.setFrameSequence(34, 25, 0.1);
    } else {
      avatar.setVisible(false);
      newspaperIsOpen = false;
      score.reset();
      newspaperSprite.setFrame(8);
      newspaperRestartY -= 5 ;
      newspaperSprite.setXY(width/2, newspaperRestartY + height/2);
      speedDifficulty = 0;
      if (newspaperRestartY < 5) {
        newspaperRestartY = 0;
        newspaperSprite.setFrameSequence(8, 17, 0.1);
        prvGameStage = "restart";
        gameStage = "menu";
      }
    }
  }

  //_________________________________________________________________________________avatarReset()

  void avatarReset() {
    avatar.setDead(true);
    counter = 0;
    thatGuyIsShocked = false;

    newAvatarY = random(height/2, height - 128);

    avatarSize = map(newAvatarY, height/2, height -100, 0.8, 3.5);
    avatarSpeed = map(newAvatarY, height/2, height -100, 50, 250);
    thatGuysSensitivity = map(newAvatarY, 200, height -100, 0.7, 0.1);
    thatGuysPanicingTime = random(60, 140);


    float velAvatar = randomSignum(avatarSpeed);
    if (velAvatar > 0) {
      avatar.setFrameSequence(2, 3, 0.1);
      newAvatarX = 0;
    } else {
      avatar.setFrameSequence(0, 1, 0.1);
      newAvatarX = width;
    }


    avatar.setScale(avatarSize);
    avatar.setVelXY(velAvatar + (speedDifficulty * velAvatar), 0);
    avatar.setXY(newAvatarX, newAvatarY);
    avatar.setDead(false);
    isNewAvatar = true;
  }

  //_________________________________________________________________________________handleNewAvatar()

  void handleNewAvatar() {
    //If the avatar goes off the left or right
    //wrap it around
    if (avatar.getX() - 64 > width || avatar.getX() + 64 < 0) {
      //score--
      score.removePoint();
      //harder
      speedDifficulty += 0.1;
      speedDifficulty *= 2;
      speedDifficulty = constrain(speedDifficulty, 0, 12);
      avatarReset();
    }
  }

  //_________________________________________________________________________________handleNewspaper()

  void handleNewspaper() {
    if (newspaperSprite.getFrame() != 34) {
      newspaperSprite.setFrameSequence(17, 34, 0.1);
    } else {
      newspaperSprite.setFrame(34);
      newspaperIsOpen = true;
      lerpNY = lerp(lerpNY, newspaperY, 0.1);
      newspaperY = height/2 + blueDetector.brightestPixel.y;
      newspaperSprite.setY(lerpNY);


      if (blueDetector.lerpY < height/3) {      
        newspaperSprite.setScale(newspaperSprite.getScale() + 0.1);
        if (newspaperSprite.getScale() > 2) {
          newspaperSprite.setScale(2);
        }
      } else if (blueDetector.lerpY > height/3) {

        newspaperSprite.setScale(newspaperSprite.getScale() - 0.1);
        if (newspaperSprite.getScale() < 1) {
          newspaperSprite.setScale(1);
          score.display();
        }
      }
    }
  }

  //_________________________________________________________________________________randomSingum()

  float randomSignum (float _x) {
    return _x * ((int)random(2) * 2 - 1);
  }

  //_________________________________________________________________________________goToCenter()

  void goToCenter() {
    if (dist(width/2, height/2, (int)avatar.getX(), (int)avatar.getY()) > 5) {
      if (avatar.getX() > width/2) {
        avatar.setX(avatar.getX() - 5);
      } else {
        avatar.setX(avatar.getX() + 5);
      }
      if (avatar.getY() > height/2) {
        avatar.setY(avatar.getY() - 5);
      } else {
        avatar.setY(avatar.getY() + 5);
      }
    }
  }

  //_________________________________________________________________________________mouseClicked()

  void mouseClicked() {
    if (gameStage == "menu") {
      prvGameStage = "menu";
      gameStage = "setting";
      return;
    } else if (gameStage == "setting") {
      prvGameStage = "setting";
      gameStage = "menu";
    }
  }

  //_________________________________________________________________________________spriteStuff()

  void spriteStuff() {
    // Sprites library stuff!
    // We get the time elapsed since the last frame (the deltaTime)
    double deltaTime = timer.getElapsedTime();
    // We update the sprites in the program based on that delta
    S4P.updateSprites(deltaTime);
    // Then we draw them on the screen
    S4P.drawSprites();
  }
}