class Ball {

  float x;
  float y;
  float size;
  float growth;
  color ballColor;
  
  int score = 0;

  boolean bouncing = true;

  float tx = random(0, 100);
  float ty = random(0, 100);

  Ball (int _x, int _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
    ballColor = #ffffff;
  }

  void update() {
    if (bouncing) {
      growth = sin(theta) * (2 * size/3);
      x = width * noise(tx);
      y = height * noise(ty);

      theta += PI/20;
      tx += 0.01;
      ty += 0.01;

      if (sin(theta) == -1) {
        colliding();
      }
    } else {
      growth -= 10;
      if (growth < -size) {
        growth = -size;
      }
    }
  }

  void colliding () {
    if (!bouncing) {
      return;
    }
    if (dist(x, y, racket.racX, racket.racY) < racket.racSize/2) {
      bouncing = true;
      score ++;
      return;
    } else {
      //println("Falling!");
      bouncing = false;
    }
  }

  void display () {
    fill (ballColor);
    ellipse(x, y, size + growth, size + growth);
    textAlign (CENTER);

    fill(#ffffff);
    text (score, width/2 , height - 50);
  }
  
  void reset(){
    growth = 0;
    bouncing = true;
    score = 0;
    
  }
}