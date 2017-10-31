float theta = 0;
float size = 200;
void setup() {
  size(600,600);
  background(0);
  fill(255);
}
void draw() {
  background(0);
  float growth = sin(theta) * (size/2);
  ellipse(width/2,height/2,size + growth,size + growth);
  theta += 0.08;
}