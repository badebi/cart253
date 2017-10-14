//

class Score {
  
  int scoreRight;
  int scoreLeft;
  
  PFont scoreFont;
  PFont winerFont;
  
  Score(){
   
    //
    scoreRight = 0;
    scoreLeft=0;
    
    //
    scoreFont = createFont("Arial",32,true);
    winerFont = createFont("Arial",52,true);
  }
  
  
  
  
  
  /////////////// Methods ///////////////

  // update()
  //
  // 

  void update() {
   if (ball.offScreenDirection == "OFF RIGHT") {
     scoreLeft += 1;
     ball.offScreenDirection = "ON SCREEN";
   } else if (ball.offScreenDirection == "OFF LEFT"){
     scoreRight += 1;
     ball.offScreenDirection = "ON SCREEN";
     }
  }

  // display()
  //
  // 
  
  void display() {
    textFont (scoreFont);
    textAlign (CENTER);
    text (scoreLeft,width/4,42);
    text (scoreRight,(3 * width/4),42);

  }
  
  void winner() {
    textFont (winerFont);
    textAlign (CENTER);
    if (scoreLeft == 11) {
      text ("YOU WIN", width/4,height/2);
      text ("YOU LOSE", 3 * width/4,height/2);
    } else if (scoreRight == 11) {
      text ("YOU WIN", 3 * width/4,height/2);
      text ("YOU LOSE", width/4,height/2);
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