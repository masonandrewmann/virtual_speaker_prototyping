
Server.killAll;
(
	//set up osc communication with processing
	NetAddr.localAddr;
	thisProcess.openPorts;
	~processing = NetAddr.new("127.0.0.1", 7000);
	// ~processing.sendMsg("/init", 1);
)

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
		OSCdef(\speaker0x, {
			arg msg;
/*			postln("received: ");
			postln(msg);*/
		}, '/speaker0/x');
	);

	(
		OSCdef(\speaker0y, {
			arg msg;
/*			postln("received: ");
			postln(msg);*/
		}, '/speaker0/y');
	);

	(
		OSCdef(\speaker0z, {
			arg msg;
/*			postln("received: ");
			postln(msg);*/
		}, '/speaker0/z');
	);

// SPEAKER 1
	(
		OSCdef(\speaker1x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker1/x');
	);

	(
		OSCdef(\speaker1y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker1/y');
	);

	(
		OSCdef(\speaker1z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker1/z');
	);

// SPEAKER 2
	(
		OSCdef(\speaker2x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker2/x');
	);

	(
		OSCdef(\speaker2y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker2/y');
	);

	(
		OSCdef(\speaker2z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker2/z');
	);

// SPEAKER 3
	(
		OSCdef(\speaker3x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker3/x');
	);

	(
		OSCdef(\speaker3y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker3/y');
	);

	(
		OSCdef(\speaker3z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker3/z');
	);

// SPEAKER 4
	(
		OSCdef(\speaker4x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker4/x');
	);

	(
		OSCdef(\speaker4y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker4/y');
	);

	(
		OSCdef(\speaker4z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker4/z');
	);

// SPEAKER 5
	(
		OSCdef(\speaker5x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker5/x');
	);

	(
		OSCdef(\speaker5y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker5/y');
	);

	(
		OSCdef(\speaker5z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker5/z');
	);

// SPEAKER 6
	(
		OSCdef(\speaker6x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker6/x');
	);

	(
		OSCdef(\speaker6y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker6/y');
	);

	(
		OSCdef(\speaker6z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker6/z');
	);

// SPEAKER 7
	(
		OSCdef(\speaker7x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker7/x');
	);

	(
		OSCdef(\speaker7y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker7/y');
	);

	(
		OSCdef(\speaker7z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker7/z');
	);

// SPEAKER 8
	(
		OSCdef(\speaker8x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker8/x');
	);

	(
		OSCdef(\speaker8y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker8/y');
	);

	(
		OSCdef(\speaker8z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker8/z');
	);

// SPEAKER 9
	(
		OSCdef(\speaker9x, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker9/x');
	);

	(
		OSCdef(\speaker9y, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker9/y');
	);

	(
		OSCdef(\speaker9z, {
			arg msg;
			postln("received: ");
			postln(msg);
		}, '/speaker9/z');
	);
)