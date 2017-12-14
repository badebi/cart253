//_________________________________________________________________________________

class Score {

  int score;
  //PFont myDopeFont;
  //PFont myNiceShadedFont;
  int textXPosision;
  int highScore;
  int comboCounter;
  int comboCoefficient;

  //_________________________________________________________________________________

  Score() {
    highScore = 0;
    comboCoefficient = 1;
    comboCounter = 0;
    textXPosision = width - 92;
    score = 0;
  }

  //_________________________________________________________________________________

  void display() {
    if (score < -14) {
      gameStage= "gameover";
    }
    fill(255, 0, 0);
    textFont(myDopeFont); // Use the new font
    textSize(64); // Font size
    textAlign(LEFT, TOP); // Center align both horizontally and vertically
    textLeading(28); // Line height for text
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

  //_________________________________________________________________________________

  void addPoint() {
    if (comboCounter % 5 == 0 && comboCounter != 0) {
      comboCoefficient ++;
    }
    if (animation.thatGuysSensitivity > 0.5) {
      score += 3;
      comboCounter += 3;
      return;
    }
    score += comboCoefficient ;
    comboCounter ++;
  }

  //_________________________________________________________________________________

  void removePoint() {
    score --;
    comboCounter = 0;
    comboCoefficient = 1;
  }

  //_________________________________________________________________________________

  void updateHighScore() {
    if (score > highScore) {
      highScore = score;
      return;
    } else if (highScore == 0 && score < 0) {
      highScore = score;
      return;
    }
  }

  //_________________________________________________________________________________

  void displayHighScore() {
    fill(255, 0, 0);
    textFont(myDopeFont); // Use the new font
    textSize(64); // Font size
    textAlign(CENTER, CENTER); // Center align both horizontally and vertically
    textLeading(28); // Line height for text
    text(highScore, width - 83, height - 72);
    //println(width - mouseX, height - mouseY);
  }

  //_________________________________________________________________________________

  void reset() {
    score = 0;
    comboCoefficient = 1;
    comboCounter = 0;
  }
}