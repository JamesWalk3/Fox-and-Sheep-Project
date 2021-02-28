class Fox {

  PVector location;
  PVector velocity;
  PVector acceleration;
  // Additional variable for size
  float r;
  float maxforce;
  float maxspeed;
  float angle;

  Fox(float x, float y) {
    acceleration = new PVector(0.0001, 0.0001);
    velocity = PVector.random2D();
    location = new PVector(x, y);
    r = 10.0;
    angle = random( 0, 2*PI );

    maxspeed = 2;
    velocity.mult(maxspeed);
    maxforce = 0.03;
  }


  void update() {

    if ( location.x < 0 ) {
      location.x = 0;
      //velocity.x *= -1;
    } 
    else if ( location.x > width ) {
      location.x = width;
      //velocity.x *= -1;
    }

    if ( location.y < 0 ) {
      location.y = 0;
      //velocity.y *= -1;
    } 
    else if ( location.y > height ) {
      location.y = height;
      //velocity.y *= -1;
    }

    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }


  // Newton’s second law; we could divide by mass if we wanted.
  void applyForce(PVector force) {
    acceleration.add(force);
  }

  // Our seek steering force algorithm
  void seek(PVector target) {
    PVector desired = PVector.sub(target, location);

    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void wander() {
    PVector centerOfCircle = location.copy();
    PVector velCopy = velocity.copy();
    velCopy.normalize();

    velCopy.mult( 100 );

    centerOfCircle.add( velCopy );

    //draw a visual for that point
    //fill(0);
    noFill();
    noStroke();
    ellipse( centerOfCircle.x, centerOfCircle.y, 5, 5 );

    noFill();
    //stroke(0);
    float rad = 40;
    ellipse( centerOfCircle.x, centerOfCircle.y, 2*rad, 2*rad );

    float ptX = centerOfCircle.x + rad * cos(angle);
    float ptY = centerOfCircle.y + rad * sin(angle);
    noFill();              //comment out if want to see what fox following
    noStroke();            //comment out if want to see what fox following
    //fill(255, 0, 0);     //uncomment if want to see what fox following
    ellipse( ptX, ptY, 4, 4 );

    angle += random( -.1, .1 );

    PVector seeker = new PVector(ptX, ptY);

    seek( seeker );
  }

  void display() {
    // fox is a triangle pointing in
    // the direction of velocity; since it is drawn
    // pointing up, we rotate it an additional 90 degrees.
    float theta = velocity.heading() + PI/2;
    noFill();       //comment out if want to see what fox following
    noStroke();     //comment out if want to see what fox following
    //fill(175);    //uncomment if want to see what fox following
    //stroke(0);    //uncomment if want to see what fox following
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    //will enter in a photo later
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    fill(#FF8503);
    stroke(0);
    endShape(CLOSE);
    popMatrix();
  }
}
