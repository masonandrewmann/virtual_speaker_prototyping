
//input source

//encode input to B-format

//play back over virtual speakers
FoaXformDisplay.new(1);

//route virtual speakers to headphones using hrtf
Server.killAll;


//boot at 48kHz!!!!!!!
(
ServerOptions.devices;
// Server.local.options.device = "Aggregate Built-in Microphone";
Server.local.options.outDevice = "External Headphones";
s.options.numOutputBusChannels = 16;
s.options.numInputBusChannels = 2;
s.options.memSize = 2.pow(20);
s.options.sampleRate(44100);
s.reboot;
)

//setup

(
~encoder = FoaEncoderMatrix.newOmni;
~diamDirs = [[0, 0], [90,315], [90, 45]].degrad;
~decoder = FoaDecoderKernel.newCIPIC(sampleRate:44100);
~sp0enc = FoaEncoderMatrix.newDirections([[0, 0]]);
~sp1enc = FoaEncoderMatrix.newDirections([[0, 0]]);
~sp2enc = FoaEncoderMatrix.newDirections([[0, 0]]);
~sp3enc = FoaEncoderMatrix.newDirections([[0, 0]]);
~sp4enc = FoaEncoderMatrix.newDirections([[0, 0]]);
~sp5enc = FoaEncoderMatrix.newDirections([[0, 0]]);
	//set up osc communication with processing
	NetAddr.localAddr;
	thisProcess.openPorts;
	~processing = NetAddr.new("127.0.0.1", 7000);
	// ~processing.sendMsg("/init", 1);
);

//main code
(
SynthDef.new(\body, {
	arg amp = 0.1,
	sp0az = 0,
	sp1az = 90,
	sp2az = 90,
	sp3az = -180,
	sp4az = -90,
	sp5az = -90,
	sp0el = 0,
	sp1el = -45,
	sp2el = 45,
	sp3el = 0,
	sp4el = 45,
	sp5el = -45;
	// sp0encD = ~sp0enc;
/*	sp1enc = FoaEncoderMatrix.newDirections([[0, 0]]),
	sp2enc = FoaEncoderMatrix.newDirections([[0, 0]]),
	sp3enc = FoaEncoderMatrix.newDirections([[0, 0]]),
	sp4enc = FoaEncoderMatrix.newDirections([[0, 0]]),
	sp5enc = FoaEncoderMatrix.newDirections([[0, 0]]);*/
	var out, sig, sigB, sig_dec, sp0, sp1, sp2, sp3, sp4, sp5;

	//generate and encode test signal
	sig = PinkNoise.ar();
	sigB = FoaEncode.ar(sig, ~encoder);

	//decode to virtual loudspeakers
	sig_dec = FoaDecode.ar(sigB,~decoder);

	//encode each loudspeaker signal to ambisonic space ((THIS IS BAD DO THIS BETTER WITHOUT AMBISONICS))
	sp0 = FoaEncode.ar(sig, ~sp0enc);
	sp1 = FoaEncode.ar(sig, ~sp1enc);
	sp2 = FoaEncode.ar(sig, ~sp2enc);
	sp3 = FoaEncode.ar(sig, ~sp3enc);
	sp4 = FoaEncode.ar(sig, ~sp4enc);
	sp5 = FoaEncode.ar(sig, ~sp5enc);
	// sp1 = FoaEncode.ar(sig, FoaEncoderMatrix.newDirections([[sp1az, sp1el]].degrad));
	// sp2 = FoaEncode.ar(sig, FoaEncoderMatrix.newDirections([[sp2az, sp2el]].degrad));
	// sp3 = FoaEncode.ar(sig, FoaEncoderMatrix.newDirections([[sp3az, sp3el]].degrad));
	// sp4 = FoaEncode.ar(sig, FoaEncoderMatrix.newDirections([[sp4az, sp4el]].degrad));
	// sp5 = FoaEncode.ar(sig, FoaEncoderMatrix.newDirections([[sp5az, sp5el]].degrad));

	sp0 = FoaTransform.ar(sp0, 'push', pi/2, sp0az, sp0el);
	sp1 = FoaTransform.ar(sp1, 'push', pi/2, sp1az, sp1el);
	sp2 = FoaTransform.ar(sp2, 'push', pi/2, sp2az, sp2el);
	sp3 = FoaTransform.ar(sp3, 'push', pi/2, sp3az, sp3el);
	sp4 = FoaTransform.ar(sp4, 'push', pi/2, sp4az, sp4el);
	sp5 = FoaTransform.ar(sp5, 'push', pi/2, sp5az, sp5el);

	// sp0 = FoaTransform.ar(sp0, 'rtt',
	//decode each loudspeaker to stereo then sum
	sp0 = FoaDecode.ar(sp0, ~decoder);
	sp1 = FoaDecode.ar(sp1, ~decoder);
	sp2 = FoaDecode.ar(sp2, ~decoder);
	sp3 = FoaDecode.ar(sp3, ~decoder);
	sp4 = FoaDecode.ar(sp4, ~decoder);
	sp5 = FoaDecode.ar(sp5, ~decoder);

	// sp1 = FoaDecode.ar(sp1, ~decoder);
	// sp2 = FoaDecode.ar(sp2, ~decoder);
	// sp3 = FoaDecode.ar(sp3, ~decoder);
	// sp4 = FoaDecode.ar(sp4, ~decoder);
	// sp5 = FoaDecode.ar(sp5, ~decoder);

	//sum them
	out = sp0 + sp1 + sp2 + sp3 + sp4 + sp5;
	Out.ar(0, out);

}
).add;
);

x = Synth(\body);


(
	//for osc initialization with Processing
		(
			OSCdef(\init, {
				arg msg;
				postln("Received initialization message from Processing!");
				// postln(msg);
				postln("Sending response message!");
				postln(" ");
				~processing.sendMsg("/init", "My current port is" + NetAddr.localAddr.ip +":" + NetAddr.localAddr.port);
				// NetAddr.localAddr.port;
			}, '/init');
		);

// SPEAKER 0
	(
		OSCdef(\speaker0, {
			arg msg;
		    var encoder;
/*			postln("recieved: ");
		    post("dist: ");
		postln(msg[1]);
		    post("azimuth: ");
		    postln(msg[2]);
		    post("elevation: ");
		    postln(msg[3]);
		postln(" ");*/

		// encoder = FoaEncoderMatrix.newDirections([msg[2], msg[3]].degrad);
		x.set(\sp0az, msg[2].degrad, \sp0el, msg[3].degrad);
		}, '/speaker0');
	);

// SPEAKER 1
	(
		OSCdef(\speaker1, {
			arg msg;
		    var encoder;
/*			postln("recieved: ");
		    post("dist: ");
		postln(msg[1]);
		    post("azimuth: ");
		    postln(msg[2]);
		    post("elevation: ");
		    postln(msg[3]);
		postln(" ");*/

		// encoder = FoaEncoderMatrix.newDirections([msg[2], msg[3]].degrad);
		x.set(\sp1az, msg[2].degrad, \sp1el, msg[3].degrad);
		}, '/speaker1');
	);

// SPEAKER 2
	(
		OSCdef(\speaker2, {
			arg msg;
		    var encoder;
/*			postln("recieved: ");
		    post("dist: ");
		postln(msg[1]);
		    post("azimuth: ");
		    postln(msg[2]);
		    post("elevation: ");
		    postln(msg[3]);
		postln(" ");*/

		// encoder = FoaEncoderMatrix.newDirections([msg[2], msg[3]].degrad);
		x.set(\sp2az, msg[2].degrad, \sp2el, msg[3].degrad);
		}, '/speaker2');
	);

// SPEAKER 3
	(
		OSCdef(\speaker3, {
			arg msg;
		    var encoder;
/*			postln("recieved: ");
		    post("dist: ");
		postln(msg[1]);
		    post("azimuth: ");
		    postln(msg[2]);
		    post("elevation: ");
		    postln(msg[3]);
		postln(" ");*/

		// encoder = FoaEncoderMatrix.newDirections([msg[2], msg[3]].degrad);
		x.set(\sp3az, msg[2].degrad, \sp3el, msg[3].degrad);
		}, '/speaker3');
	);

// SPEAKER 4
	(
		OSCdef(\speaker4, {
			arg msg;
		    var encoder;
/*			postln("recieved: ");
		    post("dist: ");
		postln(msg[1]);
		    post("azimuth: ");
		    postln(msg[2]);
		    post("elevation: ");
		    postln(msg[3]);
		postln(" ");*/

		// encoder = FoaEncoderMatrix.newDirections([msg[2], msg[3]].degrad);
		x.set(\sp4az, msg[2].degrad, \sp4el, msg[3].degrad);
		}, '/speaker4');
	);

// SPEAKER 5
	(
		OSCdef(\speaker5, {
			arg msg;
		    var encoder;
/*			postln("recieved: ");
		    post("dist: ");
		postln(msg[1]);
		    post("azimuth: ");
		    postln(msg[2]);
		    post("elevation: ");
		    postln(msg[3]);
		postln(" ");*/

		// encoder = FoaEncoderMatrix.newDirections([msg[2], msg[3]].degrad);
		x.set(\sp5az, msg[2].degrad, \sp5el, msg[3].degrad);
		}, '/speaker5');
	);
)