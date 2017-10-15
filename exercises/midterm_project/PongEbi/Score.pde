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
     
     //
     wallBounce();
  }

  // display()
  //
  // 
  
  void display() { 
    
    textFont (scoreFont);
    textAlign (CENTER);
    
    fill(#FF0000);
    text (scoreLeft, width/2, ((height - (ball.SIZE)) - (scoreLeft * ball.SIZE)) - 9 );
    
    fill(#0000FF);
    text (scoreRight, width/2, (3*ball.SIZE + (scoreRight * ball.SIZE)));
    
    wallScore();

  }
  
  void winner() {
    textFont (winerFont);
    textAlign (CENTER);
    if (scoreLeft == 11) {
      fill(#FF0000);
      text ("YOU WIN", width/4, height/2);
      fill(#0000FF);
      text ("YOU LOSE", 3 * width/4, height/2);
    } else if (scoreRight == 11) {
      fill(#0000FF);
      text ("YOU WIN", 3 * width/4, height/2);
      fill(#FF0000);
      text ("YOU LOSE", width/4, height/2);
    }
  }
  
  void wallScore(){
  
    noStroke();
    if (scoreLeft != 0 || scoreRight != 0){
      for (int i=1; i <= scoreLeft; i++){
        fill(#FF0000);
        ellipse (width/2, (height - ball.SIZE) - (i * ball.SIZE), ball.SIZE, ball.SIZE);
    } 
      for (int j=1; j <= scoreRight; j++){
        fill(#0000FF);
        ellipse (width/2, (0 + ball.SIZE) + (j * ball.SIZE), ball.SIZE, ball.SIZE);
    }
  }
  }
  
  void wallBounce() {
    if (scoreLeft != 0) {
    // Calculate possible overlaps with the paddle side by side
    boolean downInsideLeft = (ball.x + ball.SIZE/2 > width/2 - ball.SIZE/2);
    boolean downInsideRight = (ball.x - ball.SIZE/2 < width/2 + ball.SIZE/2);
    boolean downInsideTop = (ball.y + ball.SIZE/2 > (height - ball.SIZE) - (scoreLeft * ball.SIZE));
    boolean downInsideBottom = (ball.y - ball.SIZE/2 < height - ball.SIZE);
    
    // Check if the ball overlaps with the paddle
    if (downInsideLeft && downInsideRight && downInsideTop && downInsideBottom) {
      // If it was moving to the left
      if (ball.vx < 0) {
        // Reset its position to align with the right side of the paddle
        ball.x =  width/2 + ball.SIZE;
      } else if (ball.vx > 0) {
        // Reset its position to align with the left side of the paddle
        ball.x = width/2 - ball.SIZE;
      }
      // And make it bounce
      ball.vx = -ball.vx;
    }
    }
    if (scoreRight != 0){
    // Calculate possible overlaps with the paddle side by side
    boolean upInsideLeft = (ball.x + ball.SIZE/2 > width/2 - ball.SIZE/2);
    boolean upInsideRight = (ball.x - ball.SIZE/2 < width/2 + ball.SIZE/2);
    boolean upInsideTop = (ball.y + ball.SIZE/2 > ball.SIZE);
    boolean upInsideBottom = (ball.y - ball.SIZE < ball.SIZE + (scoreRight * ball.SIZE));
    
    // Check if the ball overlaps with the paddle
    if (upInsideLeft && upInsideRight && upInsideTop && upInsideBottom) {
      // If it was moving to the left
      if (ball.vx < 0) {
        // Reset its position to align with the right side of the paddle
        ball.x =  width/2 + ball.SIZE;
      } else if (ball.vx > 0) {
        // Reset its position to align with the left side of the paddle
        ball.x = width/2 - ball.SIZE;
      }
      // And make it bounce
      ball.vx = -ball.vx;
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