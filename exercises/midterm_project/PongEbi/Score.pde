//

class Score {
  
  int scoreRight;
  int scoreLeft;
  
  PFont f;
  
  Score(){
   
    //
    scoreRight = 0;
    scoreLeft=0;
    
    //
    f = createFont("Arial",32,true);
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
    textFont (f);
    text (scoreLeft,width/4,42);
    
    text (scoreRight,(3 * width/4) - 16,42);

  }
  
}