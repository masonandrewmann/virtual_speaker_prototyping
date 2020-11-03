void oscEvent(OscMessage msg){
   if(msg.addrPattern().equals("/init")){
    init_state = 1;
    println("Received initialization message from Supercollider");
    //String str = msg.get(0).stringValue();
    //println(str.substring(1, str.length()));
    println(msg.get(0));
    println(" ");
  }
}

void osc_sendSpeaker(int ind){
    // FORMAT
    // dist, azimuth, elevation
    String messName = "/speaker";
    messName = messName + String.valueOf(ind);
    Speaker thisSpeaker = speakers.get(ind);

    OscMessage speakerMess = new OscMessage(messName);
    speakerMess.add(thisSpeaker.dist);
    speakerMess.add(thisSpeaker.azimuth);
    speakerMess.add(thisSpeaker.elevation);
    oscP5.send(speakerMess, supercollider);
    
    print("Sending Speaker data: ");
    println(ind);
}

void sendAll(){
  println(speakers.size());
  for (int i = 0; i < speakers.size(); i++){
    osc_sendSpeaker(i);
  }
}

void oscInit(){
    OscMessage init = new OscMessage("/init");
    init.add(sc_add);
    oscP5.send(init);
    println(" ");
    println("Attempting to set up OSC communication on Port " + sc_add + "...");
    println("...");
    OscP5.flush(init, new NetAddress("127.0.0.1", sc_add));
    init_state = 0;
    delay(1000);
    if(init_state != 1){
      println("Supercollider not found at Port " + sc_add);
      sc_add = 57121;
      println("Attempting Port 57121...");
      println("...");
      init = new OscMessage("/init");
      init.add(sc_add);
      OscP5.flush(init, new NetAddress("127.0.0.1", sc_add));
      //supercollider = new NetAddress("127.0.0.1",  sc_add);
    }
    delay(1000);
    if(init_state != 1){
      println("Supercollider not found at Port " + sc_add);
      println("Exiting program, check NetAddr.localAddr in Supercollider");
      exit();
    } else if (init_state == 1){
      supercollider = new NetAddress("127.0.0.1", sc_add);
    }
}
