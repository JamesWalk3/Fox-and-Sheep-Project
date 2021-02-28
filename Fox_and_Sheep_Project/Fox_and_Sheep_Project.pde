Fox f;

void setup() {
  size(800, 600);
  f = new Fox(width/2, height/2);
}

void draw() {
  background(255);
  
  f.update();
  f.wander();
  f.display();
}
