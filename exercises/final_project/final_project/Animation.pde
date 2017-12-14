// Animation
//
// The class where all the super cool stuff happens
// It manages, updates and displays the Sprites, in the different stages of the game
// It handles all behaviors of avatars, background and the newspaper 

//_________________________________________________________________________________PROPERTIES

class Animation {
  // Newspaper Properties

  // Newsspaper's Y posision which is related to the blueDetector's Y
  float newspaperY;
  // To make the newspaperY's changes more smoother
  float lerpNY;
  // It's used for reseting the newspaper when the game resets
  float newspaperRestartY;
  // Is the newspaper open ?
  boolean newspaperIsOpen = false;

  // Avatar(thatGuy) Properties

  // How fast the avatar mores (pixels per second)
  float avatarSpeed; 
  // How big is the avatar
  float avatarSize;
  // is this a new avatar?
  boolean isNewAvatar;
  // New avatar's initial position
  float newAvatarX;
  float newAvatarY;
  // Is that guy Shocked?
  boolean thatGuyIsShocked;
  // adds to the avatarSpeed and makes the game harder
  float speedDifficulty = 0;
  // Each avatar when is created, has s specific sensetivity to the sound
  // based on its location on the screen
  float thatGuysSensitivity;
  // Each avatar when is created, has s specific panicking time which is the amount of
  // time that it panics after it gets scared and before he start looking for the player
  float thatGuysPanickingTime = 0;
  // Acts as a timer for panicking time
  int counter = 0;

  // Other Properties

  // The microphone's treshold which is used for menu and restarting the game
  float micThreshold;
  // The sound level (from mic)
  float level;
  // Alpha for the text 
  int alpha = 0;

  //_________________________________________________________________________________CONSTRUCTOR

  // Animation()
  //
  // It doesn't get anything from the main program and it initialize the properties whith 
  // their initial values.

  Animation() {
    prvGameStage = null;
    // Start the game from the menu
    gameStage = "menu";
    // no avatars in the beginning
    isNewAvatar = false;
    micThreshold = 0.35; 
    newspaperY = 580;
    lerpNY = 0;
    thatGuyIsShocked = false;
    avatarSpeed = 50;
    avatarSize = 1;
    // Set the background's position on screen
    background.setXY(width/2, height/2);
    // Set the background's frame sequence to play
    background.setFrameSequence(0, 11, 0.25);
  }

  //_________________________________________________________________________________METHODS

  //_________________________________________________________________________________handleAnimation()

  // void handleAnimation()
  //
  // It is called every frame by the main program and the thing it does is managing
  // the stages of the game and calls the appropriate method fot each section

  void handleAnimation() {

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

  // void menu()
  //
  // It's called at the beginning of the game by handleAnimation.
  // It's also called from the setting stage and restart stage.
  // It bring handles the newspaper's animation in the menu, has a button to go to 
  // settings, shows the highscore and wait for a player to shout to start the game.

  void menu() {
    // Don't show thatGuy
    avatar.setVisible(false);
    // Show the newspaper
    newspaperSprite.setVisible(true);
    // place the newspaper in the center
    newspaperSprite.setXY(width/2, height/2);
    // If the newspaper is in the menu page, stop it and do these stuff
    // else if it's coming from the setting stage, do one kind of animation to get to menu
    // else if it's coming from the restart stage, do another animation to get to menu
    if (newspaperSprite.getFrame() == 17) {
      // Get the current level (volume) going into the microphone
      level = mic.mix.level();
      // Stop the animation on the menu page 
      newspaperSprite.stopImageAnim();
      // display the highscore
      score.displayHighScore();

      // Things related to the "Setting" button's text
      // Make it flashing red (with changing alpha by using %)
      fill(0, 0, 255, alpha);
      alpha = (alpha + 11) % 255;
      textFont(myNiceShadedFont); // Use the new font
      textSize(16); // Font size
      textAlign(CENTER, CENTER); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      text("SettinG", 449, 449);

      // If the sound is loader than micTreshold then go to transition stage
      if (level > micThreshold) {
        prvGameStage = "menu";
        gameStage = "transition";
        transition();
        return;
      }
    } else if (prvGameStage == "setting") {
      newspaperSprite.setFrameSequence(33, 17, 0.1);
      return;
    } else if (prvGameStage != "restart") {
      newspaperSprite.setFrameSequence(0, 17, 0.1);
    }
  }

  //_________________________________________________________________________________setting()

  // void setting()
  //
  // It's called when the setting button in clicked by mouse in the menu page.
  // It shows the threshols for blueDetector and redDetector and lets you adjust them
  // it has a menu button to go back to the menu.

  void setting() { 
    // handles the animation when it comes to the setting stage
    if (prvGameStage == "menu") {
      newspaperSprite.setFrameSequence(17, 35, 0.1);
      if (newspaperSprite.getFrame() == 34) {
        newspaperSprite.setFrame(35);
        // I cheated here to avoid declaring another variable just for this :D
        prvGameStage = "setting";
      }
    } else {
      // Sets the desirable setting page according the settingPage value
      // which is changable by pressing SHIFT key
      newspaperSprite.setFrame(settingPage);

      // show the red and blue line, and the small points on the detected object locations
      // to help the player adjust the thresholds and try them if it works properly 
      blueDetector.display = true;
      redDetector.display = true;

      // Things related to the "menu" button's text
      fill(0, 0, 0, alpha);
      alpha = (alpha + 11) % 255;
      textFont(myNiceShadedFont); // Use the new font
      textSize(22); // Font size
      textAlign(CENTER, CENTER); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      text("MENU", 449, 449);

      // Things related to showing the threshold values 
      textFont(myDopeFont); // Use the new font
      textSize(88); // Font size
      textAlign(CENTER, CENTER); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      // change between showing the threshold value for blue and for the red 
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

  // void transition()
  //
  // It's called from the menu stage and it's the transition between menu and the game
  // It calls the avatarReset() to make the first avatar and make the red and blue guides 
  // invisible.

  void transition() {
    avatarReset();
    blueDetector.display = false;
    redDetector.display = false;
    prvGameStage = "transition";
    gameStage = "start";
  }

  //_________________________________________________________________________________startGame()

  // void startGame()
  //
  // It's called right after the transition stage. It calls handleNewspaper()and it 
  // checkes if the thatGuy is shocked or not, if yes it sends him to panic mode, if he
  // is not shoked yet, it waits for him to get shocked to send him to panic mode


  void startGame() {
    // Make thatGuy visible
    avatar.setVisible(true);
    // If that guy is not shocked, check until he gets shocked and send him to panic mode
    // else continue sending him to panic mode
    if (!thatGuyIsShocked) {
      // If this is a new avatar (which means if it's not the first avatar), then handle it
      // and remove a point if he leaves the screen without getting scared
      if (isNewAvatar) {
        handleNewAvatar();
      }

      handleNewspaper();

      // make sure that the news paper is open before checking the level
      if (newspaperIsOpen) {
        // Get the current level (volume) going into the microphone
        level = mic.mix.level();
      }

      // If the player's voice is reached to thatGuysSensitivity and the player is not hidden 
      // behind the newspaper, then let thatGuy panic
      if (level > thatGuysSensitivity && !playerIsHidden) {           
        goToPanicMode();
      }
    } else {
      // let him keep panicking and handle newspaper 
      handleNewspaper();
      goToPanicMode();
    }
  }

  //_________________________________________________________________________________goToPanicMode()

  // void goToPanicMode()
  //
  // It's called when player's voice scare the *** and it manages the animation of panicking
  // and the duration of it.
  // It also checks if the player is hidden when the thatGuy's panicking time is finished.
  // If the player isn't hidden on that time, the game is over and the gameOver() is gonna
  // be called, otherwise, thatGuy keeps panicking for a bit longer and then disappears 
  // and the player gets a point.

  void goToPanicMode() {
    thatGuyIsShocked = true;
    // Make thatGuy stop and make him panic
    avatar.setVelXY (0, 0);
    avatar.setFrameSequence(4, 7, 0.2);
    // Make the counter count up
    counter ++;
    // if the player is not hidden and the panicing time is finished -> Game Over
    if (!playerIsHidden) {
      // I know it's weird but I had a bug and it's fixed by adding a double check 
      if (counter > thatGuysPanickingTime && !playerIsHidden) {
        gameOver();
        return;
      }
    } else {
      // If the player was successful on SSHOUT him, give him a point abnd reset the avatar.
      if (counter > thatGuysPanickingTime + 15) {
        score.addPoint();
        avatarReset();
      }
    }
  }

  //_________________________________________________________________________________gameOver()

  // void gameOver()
  //
  // It's called when thatGuy finishes panicking and the player is not covered himself by 
  // the newspaper, so here we have the moment of realization for thatGuy ... he runes right
  // to the player's face to smash his face, and that's what this method does.
  // it also updates the highscore before reseting the game.

  void gameOver() {
    prvGameStage = "start";
    gameStage = "gameover";
    // Get the current level (volume) going into the microphone
    level = mic.mix.level();

    // Things related to the "Game Over" text, with random colors
    fill(random(0, 255), random(0, 255), random(0, 255));
    textFont(myNiceShadedFont); // Use the new font
    textSize(64); // Font size
    textAlign(CENTER, CENTER); // Center align both horizontally and vertically
    textLeading(28); // Line height for text
    text("Game Over", width / 2, height / 2);

    // stop the avatar in it's position
    avatar.setVelXY (0, 0);
    // resize the avatar and animate it (so we think that he is coming towards us
    avatar.setScale (avatarSize) ;
    avatar.setFrameSequence(8, 9, 0.2);
    avatarSize = avatarSize + 0.2 ;
    // don't let thatGuy to get bigger than a certain size
    avatarSize = constrain(avatarSize, 1, 6);
    // bring thatGuy to the center
    goToCenter();

    // lerp() Calculates a number between two numbers at a specific increment.
    // so in makes the newspaper movements (according to the blueDetector)
    // much more smoother. 
    //bring the newspeper down so we can injoy seeing thatGuy's mad face
    lerpNY = lerp(lerpNY, newspaperY, 0.25);
    newspaperY = height/2 + blueDetector.brightestPixel.y;
    newspaperSprite.setY(lerpNY);
    newspaperY = constrain(newspaperY, 580, 780);
    newspaperRestartY = newspaperY;
    
    // display the score
    score.display();
    // update the highscore
    score.updateHighScore();

    // if the player shouts., restart the game
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
    thatGuysPanickingTime = random(60, 140);


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