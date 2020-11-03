import controlP5.*;
import java.util.*;
import oscP5.*;
import netP5.*;

//OSC
OscP5 oscP5;
OscP5 initOsc;
NetAddress supercollider;
int sc_add = 57120;
int init_state = -1;

//gui
ControlP5 cp5;
PFont mono;

//speakers list
ArrayList<Speaker> speakers;
int moving = -1;
int movingZ = -1;
int speaker_sel = 0;

//user input
Mover user;

void setup(){
  size(1600, 800);
  
    //set up gui
  initGui();
  mono = createFont("Courier", 64);
  textFont(mono);
  
  //create initial speakers
  speakers = new ArrayList<Speaker>();
  for (int i = 0; i < 1; i ++){
    speakers.add(new Speaker(random(width/2), random(height), 0));
  }
  
  //set up OSC
   oscP5 = new OscP5(this, 7000);
   oscInit();
   
  //create user
  user = new Mover(1, width/4, height/2);
}
  
void draw(){
  background(54);
  
  //draw background
  draw_axes();
  
  //draw speakers
    for (Speaker s : speakers){
    s.update();
    s.show();
    s.showVert();
  }
  
  //draw user
  user.update();
  user.display();
  //test osc on first speaker
  sendAll();
  
    if (speaker_sel != -1){
    Speaker showit = speakers.get(speaker_sel);
    showit.showRing();
  }
  
  if ( moving != -1){
    Speaker moveThis = speakers.get(moving);
    moveThis.pos.x = mouseX;
    if(moveThis.pos.x > width/2) moveThis.pos.x = width/2;
    if(moveThis.pos.x < 0) moveThis.pos.x = 0;
    moveThis.pos.y = mouseY;
    if(moveThis.pos.y > height) moveThis.pos.y = height;
    if(moveThis.pos.y < 0) moveThis.pos.y = 0;
  } else if (movingZ != -1){
    Speaker moveThis = speakers.get(movingZ);
    moveThis.pos.z = (height - mouseY) - height/4;
    if(moveThis.pos.z > 3*height/4) moveThis.pos.z = 3*height/4;
    if(moveThis.pos.z < 0) moveThis.pos.z = 0;
  }
  
}
  
void draw_axes(){
  stroke(255);
  strokeWeight(5);
  line(width/2, 0, width/2, height);
  line(width/2, 3*height/4, width, 3*height/4);
  stroke(0, 0, 255);
  strokeWeight(5);
  line(width/4, 0, width/4, height);
  line(0, height/2, width/2, height/2);
  stroke(0, 255, 0);
  strokeWeight(1);
  for (int i = 0; i < 20; i++){
    float colVal = i * width/40;
    float rowVal = i * height/20;
    line(0, rowVal, width/2, rowVal);
    line(colVal, 0, colVal, height);
  }
  
  stroke(0);
  strokeWeight(5);
  fill(255);
  rectMode(CENTER);
  rect(width/4, 30, 200, 40);
  rect(3*width/4, 30, 200, 40);
  textAlign(CENTER, CENTER);
  fill(0);
  textFont(mono);
  textSize(32);
  text("top view", width/4, 26);
  text("side view", 3*width/4, 26);
}
