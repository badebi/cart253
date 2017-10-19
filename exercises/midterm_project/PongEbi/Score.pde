// CHANGED // Score
// CHANGED //
// CHANGED // A class that defines a score that calculates the score
// CHANGED // and shows it as in number and score points (circles) which creates the score wall
// CHANGED // in the mmiddle of the window 

class Score {
  /////////////// Properties ///////////////

  // CHANGED // the score for both players
  int scoreRight;
  int scoreLeft;

  // CHANGED // font stuff
  PFont scoreFont;
  PFont winerFont;
  PFont loserFont;
  PFont resetFont;
  
  // CHANGED // size of the score balls (points)
  int scoreSize;

  // CHANGED // the final score ... so people can cange it here and play more
  int winnerScore = 13;


  /////////////// Constructor ///////////////

  // CHANGED // Score()
  // CHANGED //
  // CHANGED // sets the inintial values to the scores which is zero
  // CHANGED // sets the score point (ball) size
  // CHANGED // sets the font style and size
  Score() {
    scoreRight = 0;
    scoreLeft=0;

    scoreFont = createFont("Arial", 32, true);

    scoreSize = 16;
  }





  /////////////// Methods ///////////////

  // CHANGED // update()
  // CHANGED //
  // CHANGED // This is called by the main program once per frame.
  // CHANGED // it gives each player score base on the way ball goes off screen


  void update() {
    if (ball.offScreenDirection == "OFF RIGHT") {
      scoreLeft += 1;
      ball.offScreenDirection = "ON SCREEN";
    } else if (ball.offScreenDirection == "OFF LEFT") {
      scoreRight += 1;
      ball.offScreenDirection = "ON SCREEN";
    }
    // CHANGED // this is for when the sceen size changes and it updates right paddles initial X which is
    // CHANGED // important for the ball jump
    // CHANGED // I don't remember why did
    // CHANGED // I put it here ... but I'm sure I tried it to put it in paddle class but it didn't work
    if (screenSizeChanged) {
      rightPaddle.initialX =  windowWidth - PADDLE_INSET;
    }
  }

  // CHANGED // display()
  //
  // CHANGED // displays the scores and the score points (balls) (score wall)

  void display() { 

    textFont (scoreFont);
    textAlign (CENTER);

    fill(#FF0000);
    text (scoreLeft, width/2 + scoreSize + 12, height - scoreSize - 9);

    fill(#0000FF);
    text (scoreRight, width/2 - scoreSize - 12, (3*scoreSize));

    wallScore();
  }

  // CHANGED // winner ()
  // CHANGED //
  // CHANGED // it's called when the game ends
  // CHANGED // check who won and tells him/her that you won 
  // CHANGED // and tells the looser that she/he lose
  // CHANGED // and it says to press enter to reset
  // CHANGED // I used some random sizes and colors to make it more apealing

  void winner() {
    float R = random(255);
    float G = random (255);
    float B = random (255);
    float resetFontSize = random (15,50);
    float winnerFontSize = random (42,52);
    
    winerFont = createFont("Arial", winnerFontSize, true);
    loserFont = createFont("Arial", winnerFontSize/2, true);
    resetFont = createFont("Arial", resetFontSize, true);

    textAlign (CENTER);
    if (scoreLeft == winnerScore) {
      textFont (winerFont);
      fill(#FF0000);
      text ("YOU WIN", width/4, height/2);
      
      textFont (loserFont);
      fill(#0000FF);
      text ("YOU LOSE", 3 * width/4, height/2);
      
      textFont (resetFont);
      fill(R,G,B);
      text ("Press ENTER to reset", width/2, 3 * height/4);
    } else if (scoreRight == winnerScore) {
      textFont (winerFont);
      fill(#0000FF);
      text ("YOU WIN", 3 * width/4, height/2);
      
      textFont (loserFont);
      fill(#FF0000);
      text ("YOU LOSE", width/4, height/2);
      
      textFont (resetFont);
      fill(R,G,B);
      text ("Press ENTER to reset", width/2, 3 * height/4);
    }
  }

  // CHANGED // wallScore ()
  // CHANGED //
  // CHANGED // it shows the score as litte balls (points) for each player in different places
  // CHANGED // with different colors 
  // CHANGED // these points are gonna make a wall and the ball is gonna bounce of it (if it,s on the ground level)

  void wallScore() {

    noStroke();
    // CHANGED // it's start drawing the points after someone scores 
    if (scoreLeft != 0 || scoreRight != 0) {
      // CHANGED // draws all the left player's points (balls) each frame
      for (int i=1; i <= scoreLeft; i++) {
        // CHANGED // because of the widow size, the score balls (points) are gonna overlape after a
        // CHANGED //certain poit ... so I tried to limit them by doing so.
        int _i = i;
        _i = constrain(_i, 1, 13);

        // CHANGED // draws a ball (point) (a wall brick) :))) (so many names for this shit)
        fill(#FF0000); 
        ellipse (width/2, (height - scoreSize) - (_i * scoreSize), scoreSize, scoreSize);

        // CHANGED // then I tried to builde another wall besides it so I can players can play and play 
        // CHANGED //and the game gets harder and harder ... but because of lack of time I couldn't mange to do so
        // CHANGED // sorry :D

        //if (scoreLeft > 13){
        //  fill(#FF0000); 
        //  ellipse (width/2 - scoreSize, (height - scoreSize) - ( (i-13) * scoreSize), scoreSize, scoreSize);
        //}
      } 
      for (int j=1; j <= scoreRight; j++) {
        int _j = j;
        _j = constrain(_j, 1, 13);
        fill(#0000FF);
        ellipse (width/2, (0 + scoreSize) + (_j * scoreSize), scoreSize, scoreSize);
      }
    }
  }


  // CHANGED // keyPressed ()
  // CHANGED //
  // CHANGED // it's called when the game ends, so if the players wnt to play again,
  // CHANGED // by pressing enter they can do so
  // CHANGED // resets everything to it's initial value

  void keyPressed() {
    if (key == ENTER || key == RETURN) {
      ball.reset();
      leftPaddle.reset();
      rightPaddle.reset();

      scoreLeft=0;
      scoreRight=0;
    }
  }
}