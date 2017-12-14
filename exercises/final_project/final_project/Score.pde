// Score
//
// Simply, it handles the scoring system and displays them. It gives you points if you scare
// a guy, and you loos a point if you let them pass without scaring them. you get bonus points 
// if you scare a guy who is a bit far, and if you scare 5 guy in a row, you start getting 
// combo point and your score is getting mutiplied.
// It also updates the highscore and displays it in the menu section.

//_________________________________________________________________________________PROPERTIES

class Score {
  // obviously it's to store the score
  int score;
  // to manipulate the text posision to make it fit perfectly in the box at all time
  int textXPosision;
  // to store the highsscore
  int highScore;
  // I think I'm just repeating myself :D is't it obvious or should I comment EVERYTHING?
  // to keep track of the guys who got scared in a row without loosing points
  int comboCounter;
  // no comment
  int comboCoefficient;

  //_________________________________________________________________________________Score()

  // Score()
  //
  // It doesn't need to get anything from the main program and it initializes the values
  // of the properties.

  Score() {
    highScore = 0;
    comboCoefficient = 1;
    comboCounter = 0;
    textXPosision = width - 92;
    score = 0;
  }

  //_________________________________________________________________________________display()

  // void display()
  //
  // It's called by animation.handleNewspaper() and animation.gameOver().
  // It displays the score on top right corner of the newspaper. but not when the newspaper
  // is scaled and covers the whole window.
  // After loosing so many points, when the score reaches to -15, game will be over
  // It also displays the combo sign and its comboCoefficient.

  void display() {
    if (comboCoefficient > 1) {
      fill(random(0, 255), random(0, 255), random(0, 255));
      textFont(myNiceShadedFont); // Use the new font
      textSize(22); // Font size
      textAlign(CENTER, BOTTOM); // Center align both horizontally and vertically
      textLeading(28); // Line height for text
      text("combo "+ comboCoefficient +"x", 533, animation.lerpNY - height / 2 + 15);
    }

    if (score < -14) {
      gameStage= "gameover";
    }

    fill(255, 0, 0);
    textFont(myDopeFont); // Use the new font
    textSize(64); // Font size
    textAlign(LEFT, TOP); // Center align both horizontally and vertically
    textLeading(28); // Line height for text

    // These are for adjusting the size in different circumstances
    if (score < 0 || score > 9) {
      textXPosision = width - 110;
      textSize(64);
      if (score < -9) {
        textXPosision = width - 119;
        textSize(56);
      }
    } else if (score < 10) {
      textXPosision = width - 90;
      textSize(64);
    }
    text(score, textXPosision, animation.lerpNY - height / 2 + 36);
  }

  //_________________________________________________________________________________addPoint()

  // void addPoint()
  // 
  // It's called by animation.goToPanicMode(), when an avatar gets scared to death, while the
  // player is hidden, and then he dies.
  // player gets 3 points if thatGuysSensitivity > 0.5, and 1 point for each time he/she scares
  // someone.
  // After 5 points in a row, your new points gets multiplied by comboCoefficient's value, which
  // increases by 1 each 5 points (in a row).

  void addPoint() {
    if (comboCounter % 5 == 0 && comboCounter != 0) {
      comboCoefficient ++;
    }
    if (animation.thatGuysSensitivity > 0.5) {
      score += 3;
      comboCounter += 3;
      return;
    }
    score += comboCoefficient * (comboCounter - 5) ;
    comboCounter ++;
  }

  //_________________________________________________________________________________removePoint()

  // void removePoint()
  //
  // It's called by animation.handleNewAvatar(), each time an avatar leaves the frame without
  // getting scared. 

  void removePoint() {
    score --;
    // reset these values
    comboCounter = 0;
    comboCoefficient = 1;
  }

  //_________________________________________________________________________________updateHighScore()

  // updateHighScore()
  //
  // It's called by animation.gameOver() in  updates the highscore, even if it is blow zero 

  void updateHighScore() {
    if (score > highScore) {
      highScore = score;
      return;
    } else if (highScore == 0 && score < 0) {
      highScore = score;
      return;
    }
  }

  //_________________________________________________________________________________displayHighScore()

  // void displayHighScore()
  //
  // It's called by animation.menu() and it displays the highscore on the newspaper menu

  void displayHighScore() {
    fill(255, 0, 0);
    textFont(myDopeFont); // Use the new font
    textSize(64); // Font size
    textAlign(CENTER, CENTER); // Center align both horizontally and vertically
    textLeading(28); // Line height for text
    text(highScore, width - 83, height - 72);
    //println(width - mouseX, height - mouseY);
  }

  //_________________________________________________________________________________reset()

  // void reset()
  //
  // It's called by animation.reStart() and it resets the score, comboCoefficient and
  // comboCounter to their initial values.

  void reset() {
    score = 0;
    comboCoefficient = 1;
    comboCounter = 0;
  }
}