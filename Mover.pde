class Mover{
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float radius;
  float mass;
  
  float angle = 0;
  float aVelocity = 0;
  float aAcceleration= 0;
  
  Mover(float m, float x, float y){
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0, 0);
    mass = m;
    radius = 40;
  }
  
  void update(){
    velocity.add(acceleration);
    velocity.x = constrain(velocity.x, -4, 4);
    velocity.y = constrain(velocity.y, -4, 4);
    location.add(velocity);
    

    aVelocity += aAcceleration;
    aVelocity = constrain(aVelocity, -0.5, 0.5);
    angle += aVelocity%(2 * PI);
    
    acceleration.mult(0);
  }
  
  void applyForce(PVector force){
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void display(){
    stroke(0);
    fill(100, 200);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    triangle(0, 20, 20 * cos(radians(315)), 20 * sin(radians(315)), -20 * cos(radians(315)), 20 * sin(radians(315)));
    popMatrix();
  }
  
  void checkEdges(){
    if (location.x > width / 2 - radius){
      location.x = width / 2 - radius;
      velocity.x *= -1;
    }
    else if (location.x < radius) {
      location.x = radius;
      velocity.x *= -1;
    }
    if (location.y > height - radius) {
      location.y = height - radius;
      velocity.y *= -1;
    }
    else if (location.y < radius) {
      location.y = radius;
      velocity.y *= -1;
    }
  }
  
  
  void followMouse(){
    PVector force = new PVector(mouseX - location.x, mouseY - location.y);
    force.normalize();
    force.mult(0.02);
    applyForce(force);
  }
}
