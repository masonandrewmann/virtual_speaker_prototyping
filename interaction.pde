void mousePressed(){
  for (int i = 0; i < speakers.size(); i++){
    Speaker b = speakers.get(i);
    if( b.isClicked()){
        moving = i;
        speaker_sel = i;
        break;
    } else if (b.isZClicked()){
      movingZ = i;
      speaker_sel = i;
      break;
    }
  }
}

void mouseReleased(){
  moving = -1;
  movingZ = -1;
}

void keyPressed(){
  //adding and deleting speakers
  if (key == ' '){
    speakers.add(new Speaker(width/2, height/2, 0));
  } else if (key == BACKSPACE){
    Iterator<Speaker> it = speakers.iterator();
    while(it.hasNext()){
      Speaker sp = it.next();
      PVector speakerLoc = new PVector(sp.pos.x, sp.pos.y);
      PVector mouseLoc = new PVector(mouseX, mouseY);
      if(speakerLoc.dist(mouseLoc) <= sp.r){
       it.remove();
      }
  }
  }
  
  //moving user
  if (key == CODED){
    if (keyCode == LEFT){
      user.aVelocity = -0.03;
    };
    if (keyCode == RIGHT){
      user.aVelocity = 0.03;
    };
    if (keyCode == UP){
      user.velocity.x = cos(user.angle);
      user.velocity.y = sin(user.angle);
    }
  }
}

//initialize gui elements in setup
void initGui(){
    cp5 = new ControlP5(this);
  
  cp5.addSlider("numSpeakers")
    .setPosition(20, 40)
    .setRange(1, 10)
    .setNumberOfTickMarks(10)
    .setValue(2)
    ;
    
  cp5.getController("numSpeakers").setCaptionLabel("# of speakers");
}

void numSpeakers(float theValue){
  //int currLen = speakers.size();
  //int diff = currLen - (int)theValue;
  //if (diff > 0){
  //  for (int i = diff; i < 0;
  //} else if (diff < 0){
    
  //}
}

void keyReleased(){
  if (key == CODED){
    if (keyCode == LEFT){
      user.aVelocity = 0;
    };
    if (keyCode == RIGHT){
      user.aVelocity = 0;
    };
    if (keyCode == UP){
      user.velocity.x = 0;
      user.velocity.y = 0;
    }
  }
}
