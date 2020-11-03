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
