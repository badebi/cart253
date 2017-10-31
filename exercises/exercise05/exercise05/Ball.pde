class Ball {

  float x;
  float y;
  float size;
  float growth;
  color ballColor;

  float tx = random(0, 100);
  float ty = random(0, 100);

  Ball (int _x, int _y, int _size) {
    x = _x;
    y = _y;
    size = _size;
    ballColor = #000000;
  }

  void update() {
    growth = sin(theta) * (size/2);
    x = width * noise(tx);
    y = height * noise(ty);

    theta += 0.08;
    tx += 0.01;
    ty += 0.01;
    
  }

  boolean colliding () {
    if (x > (racket.racX - racket.racSize/2) && x < (racket.racX + racket.racSize/2)) {
      if (y > (racket.racY - racket.racSize/2) && y < (racket.racY + racket.racSize/2)) {
        return (true);
      }
    } 
      return (false);
  }

  void display () {
    fill (ballColor);
    ellipse(x, y, size + growth, size + growth);
  }
}