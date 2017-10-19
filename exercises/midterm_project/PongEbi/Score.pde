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
  Score(){
    scoreRight = 0;
    scoreLeft=0;

    scoreFont = createFont("Arial",32,true);
    winerFont = createFont("Arial",52,true);
    
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
   } else if (ball.offScreenDirection == "OFF LEFT"){
     scoreRight += 1;
     ball.offScreenDirection = "ON SCREEN";
     }
     // CHANGED // this is for when the sceen size changes and it updates right paddles initial X which is
     // CHANGED // important for the ball jump
     // CHANGED // I don't remember why did
     // CHANGED // I put it here ... but I'm sure I tried it to put it in paddle class but it didn't work
     if (screenSizeChanged){
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
  
  void winner() {
    textFont (winerFont);
    textAlign (CENTER);
    if (scoreLeft == winnerScore) {
      fill(#FF0000);
      text ("YOU WIN", width/4, height/2);
      fill(#0000FF);
      text ("YOU LOSE", 3 * width/4, height/2);
    } else if (scoreRight == winnerScore) {
      fill(#0000FF);
      text ("YOU WIN", 3 * width/4, height/2);
      fill(#FF0000);
      text ("YOU LOSE",  width/4, height/2); 
    }
  }
  
  // CHANGED // wallScore ()
  // CHANGED //
  // CHANGED // it shows the score as litte balls (points) for each player in different places
  // CHANGED // with different colors 
  // CHANGED // these points are gonna make a wall and the ball is gonna bounce of it (if it,s on the ground level)
  
  void wallScore(){
  
    noStroke();
    // CHANGED // it's start drawing the points after some one scores something
    if (scoreLeft != 0 || scoreRight != 0){
      for (int i=1; i <= scoreLeft; i++){
        
        int _i = i;
        _i = constrain(_i, 1, 13);
        
        fill(#FF0000); 
        ellipse (width/2, (height - scoreSize) - (_i * scoreSize), scoreSize, scoreSize);
        
        
        //if (scoreLeft > 13){
        //  fill(#FF0000); 
        //  ellipse (width/2 - scoreSize, (height - scoreSize) - ( (i-13) * scoreSize), scoreSize, scoreSize);
        //}
        
          } 
      for (int j=1; j <= scoreRight; j++){
        fill(#0000FF);
        ellipse (width/2, (0 + scoreSize) + (j * scoreSize), scoreSize, scoreSize);
    }
  }
  }
  
   
  
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