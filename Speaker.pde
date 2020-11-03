class Speaker{
  PVector pos;
  float r;
  PVector vel;
  float azimuth;
  float elevation;
  float dist;
  
  PVector referenceLoc;
  
  Speaker(float x, float y, float z){
    pos = new PVector(x, y, z);
    r = 20;
    vel = new PVector(0, 0, 0);
    referenceLoc = user.location;
  }
  
  void show(){
    noStroke();
    fill(map(pos.z, 0, 3*height/4, 0, 255));
    ellipse(pos.x, pos.y, r*2, r*2);
  }
  
  void showRing(){
   noFill();
   stroke(255, 0, 0);
   strokeWeight(3);
   ellipse(pos.x, pos.y, r*2, r*2);
   ellipse(pos.x + width/2, 3*height/4 - pos.z, r*2, r*2);
  }
  
  void showVert(){
    noStroke();
    fill(map(pos.z, 0, 3*height/4, 0, 255));
    ellipse(pos.x + width/2, 3*height/4 - pos.z, r*2, r*2);
  }
  
    void update(){
    pos.add(vel);
    if (pos.x > width || pos.x < 0) vel.x *= -1;
    if (pos.y > height || pos.y < 0) vel.y *= -1;
    calculateVectors();
  }
  
  boolean isClicked(){
    PVector mouseLoc = new PVector(mouseX, mouseY);
    PVector xyLoc = new PVector(pos.x, pos.y);
    if(xyLoc.dist(mouseLoc) <= r){
    return true;
    } else {
      return false;
    }
  }

  boolean isZClicked(){
    PVector mouseLoc = new PVector(mouseX, mouseY);
    PVector vertLoc = new PVector(pos.x + width/2, 3*height/4 - pos.z);
    if(vertLoc.dist(mouseLoc) <= r){
      return true;
    } else {
      return false;
    }
  }
  
  void calculateVectors(){
    PVector refLocReal = new PVector(referenceLoc.x - width/4, -1 * (referenceLoc.y - width/4), referenceLoc.z);
    float x = (pos.x - width/4) - refLocReal.x;
    float y = (-1 * (pos.y - width/4)) - refLocReal.y;
    float z = pos.z;
    PVector origin = new PVector(0, 0, 0);
    dist = origin.dist(new PVector(x, y, z));
    //dist = sqrt(sq(pos.x) + sq(pos.y) + sq(pos.z));
    
    elevation = 90 - degrees(acos(z / dist));
    //elevation = atan2(pos.y, pos.x);
    
    azimuth = degrees(atan(y / x));
    print("PRE:azimuth: ");
    println(azimuth);
    azimuth = azimuth - user.angleDeg;
    //azimuth = acos(pos.z / dist);
    
    if (x <= 0 && y <= 0) azimuth += 180;
    else if ( x <= 0 && y >=0) azimuth = (90 - azimuth * -1) + 90;
    else if ( x >= 0 && y <= 0) azimuth = (90 - azimuth * -1) + 270;
    //elevation = degrees(atan(sqrt(pow(x, 2) + pow(y, 2))/z));
    
     dist = map(dist, 0, width/4*sqrt(2), 0, 1);
     dist = 1 - dist;
    
    //print("x: ");
    //print(x);
    //print(", y: ");
    //print(y);
    //print(", z: ");
    //println(z);
    print("dist: ");
    println(dist);
    //print("azimuth: ");
    //println(azimuth);
    //print("elevation: ");
    //println(elevation);
    //println(refLocReal);
    //println(user.angle);
    //println(user.angleDeg);

  }
}
