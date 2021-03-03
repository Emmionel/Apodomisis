/*
https://thormagnusson.gitbooks.io/scoring/content/PartII/chapter11.html
*/

//Main Flute Synth
(
SynthDef("Flute1", { arg scl = 0.2, freq = 442, ipress = 0.9, ibreath = 0.01, ifeedbk1 = 0.4, ifeedbk2 = 0.4, dur = 1, gate = 1, amp = 2, vibrato=2.8;
    var kenv1, kenv2, kenvibr, kvibr, sr, cr, block, poly, signalOut, ifqc,  fdbckArray;
    var aflow1, asum1, asum2, afqc, atemp1, ax, apoly, asum3, avalue, atemp2, aflute1;

    sr = SampleRate.ir;
    cr = ControlRate.ir;
    block = cr.reciprocal;
    ifqc = freq;
//	 ifqc = pch;
    // noise envelope
    kenv1 = EnvGen.kr(Env.new(
        [ 0.0, 1.0 * ipress, ipress, ipress, 0.0 ], [ 0.06, 0.3, dur - 0.46, 0.2 ], 'linear' )
    );
    // overall envelope
    kenv2 = EnvGen.kr(Env.new(
        [ 0.0, amp, amp, 0.0 ], [ 0.1, dur - 0.02, 0.1 ], 'linear' ), doneAction: 2
    );
    // vibrato envelope
    kenvibr = EnvGen.kr(Env.new( [ 0.0, 0.0, 1, 1, 0.0 ], [ 0.5, 0.5, dur - 1.5, 0.5 ], 'linear') )*vibrato;
    // create air flow and vibrato
    aflow1 = LFClipNoise.ar( sr, kenv1 );
    kvibr = SinOsc.ar( 5, 0, 0.1 * kenvibr );
    asum1 = ( ibreath * aflow1 ) + kenv1 + kvibr;
    afqc = ifqc.reciprocal - ( asum1/20000 ) - ( 9/sr ) + ( ifqc/12000000 ) - block;
    fdbckArray = LocalIn.ar( 1 );
    aflute1 = fdbckArray;
    asum2 = asum1 + ( aflute1 * ifeedbk1 );
    //ax = DelayL.ar( asum2, ifqc.reciprocal * 0.5, afqc * 0.5 );
    ax = DelayC.ar( asum2, ifqc.reciprocal - block * 0.5, afqc * 0.5 - ( asum1/ifqc/cr ) + 0.001 );
    apoly = ax - ( ax.cubed );
    asum3 = apoly + ( aflute1 * ifeedbk2 );
    avalue = LPF.ar( asum3, 2000 );
    aflute1 = DelayC.ar( avalue, ifqc.reciprocal - block, afqc );
    fdbckArray = [ aflute1 ];
    LocalOut.ar( fdbckArray );
    signalOut = avalue;
    OffsetOut.ar( 0, [ signalOut * kenv2, signalOut * kenv2 ] );
}).add;
)

// Flute Synth with air effect
(
SynthDef("Flute2", { arg scl = 0.2, freq = 442, ipress = 0.9, ibreath = 0.09, ifeedbk1 = 0.4, ifeedbk2 = 0.4, dur = 1, gate = 1, amp = 2, vibrato=0.2;
    var kenv1, kenv2, kenvibr, kvibr, sr, cr, block, poly, signalOut, ifqc,  fdbckArray;
    var aflow1, asum1, asum2, afqc, atemp1, ax, apoly, asum3, avalue, atemp2, aflute1;

    sr = SampleRate.ir;
    cr = ControlRate.ir;
    block = cr.reciprocal;
    ifqc = freq;
//	 ifqc = pch;
    // noise envelope
    kenv1 = EnvGen.kr(Env.new(
        [ 0.0, 1.1 * ipress, ipress, ipress, 0.0 ], [ 0.06, 0.2, dur - 0.46, 0.2 ], 'linear' )
    );
    // overall envelope
    kenv2 = EnvGen.kr(Env.new(
        [ 0.0, amp, amp, 0.0 ], [ 0.1, dur - 0.02, 0.1 ], 'linear' ), doneAction: 2
    );
    // vibrato envelope
    kenvibr = EnvGen.kr(Env.new( [ 0.0, 0.0, 1, 1, 0.0 ], [ 0.5, 0.5, dur - 1.5, 0.5 ], 'linear') )*vibrato;
    // create air flow and vibrato
    aflow1 = LFClipNoise.ar( sr, kenv1 );
    kvibr = SinOsc.ar( 5, 0, 0.1 * kenvibr );
    asum1 = ( ibreath * aflow1 ) + kenv1 + kvibr;
    afqc = ifqc.reciprocal - ( asum1/20000 ) - ( 9/sr ) + ( ifqc/12000000 ) - block;
    fdbckArray = LocalIn.ar( 1 );
    aflute1 = fdbckArray;
    asum2 = asum1 + ( aflute1 * ifeedbk1 );
    //ax = DelayL.ar( asum2, ifqc.reciprocal * 0.5, afqc * 0.5 );
    ax = DelayC.ar( asum2, ifqc.reciprocal - block * 0.5, afqc * 0.5 - ( asum1/ifqc/cr ) + 0.001 );
    apoly = ax - ( ax.cubed );
    asum3 = apoly + ( aflute1 * ifeedbk2 );
    avalue = LPF.ar( asum3, 2000 );
    aflute1 = DelayC.ar( avalue, ifqc.reciprocal - block, afqc );
    fdbckArray = [ aflute1 ];
    LocalOut.ar( fdbckArray );
    signalOut = avalue;
    OffsetOut.ar( 0, [ signalOut * kenv2, signalOut * kenv2 ] );
}).add;
)

// Flute Synth just with air
(
SynthDef("Flute3", { arg scl = 0.2, freq = 442, ipress = 0.9, ibreath = 0.5, ifeedbk1 = 0.4, ifeedbk2 = 0.4, dur = 1, gate = 1, amp = 0.8, vibrato=0.4;
    var kenv1, kenv2, kenvibr, kvibr, sr, cr, block, poly, signalOut, ifqc,  fdbckArray;
    var aflow1, asum1, asum2, afqc, atemp1, ax, apoly, asum3, avalue, atemp2, aflute1;

    sr = SampleRate.ir;
    cr = ControlRate.ir;
    block = cr.reciprocal;
    ifqc = freq;
//	 ifqc = pch;
    // noise envelope
    kenv1 = EnvGen.kr(Env.new(
        [ 0.0, 1.1 * ipress, ipress, ipress, 0.0 ], [ 0.06, 0.2, dur - 0.46, 0.2 ], 'linear' )
    );
    // overall envelope
    kenv2 = EnvGen.kr(Env.new(
        [ 0.0, amp, amp, 0.01 ], [ 0.1, dur - 0.02, 0.1 ], 'linear' ), doneAction: 2
    );
    // vibrato envelope
    kenvibr = EnvGen.kr(Env.new( [ 0.0, 0.0, 1, 1, 0.0 ], [ 0.5, 0.5, dur - 1.5, 0.5 ], 'linear') )*vibrato;
    // create air flow and vibrato
    aflow1 = LFClipNoise.ar( sr, kenv1 );
    kvibr = SinOsc.ar( 5, 0, 0.1 * kenvibr );
    asum1 = ( ibreath * aflow1 ) + kenv1 + kvibr;
    afqc = ifqc.reciprocal - ( asum1/20000 ) - ( 9/sr ) + ( ifqc/12000000 ) - block;
    fdbckArray = LocalIn.ar( 1 );
    aflute1 = fdbckArray;
    asum2 = asum1 + ( aflute1 * ifeedbk1 );
    //ax = DelayL.ar( asum2, ifqc.reciprocal * 0.5, afqc * 0.5 );
    ax = DelayC.ar( asum2, ifqc.reciprocal - block * 0.5, afqc * 0.5 - ( asum1/ifqc/cr ) + 0.001 );
    apoly = ax - ( ax.cubed );
    asum3 = apoly + ( aflute1 * ifeedbk2 );
    avalue = LPF.ar( asum3, 2000 );
    aflute1 = DelayC.ar( avalue, ifqc.reciprocal - block, afqc );
    fdbckArray = [ aflute1 ];
    LocalOut.ar( fdbckArray );
    signalOut = avalue;
    OffsetOut.ar( 0, [ signalOut * kenv2, signalOut * kenv2 ] );
}).add;
)


//Test of synths

Synth("Flute1");
Synth("Flute2");
Synth("Flute3");


/*
https://gist.github.com/iani/d8d6545a172042dfbcd48f67a72cdfe5#file-pbind_score-scd
*/

// Fuction for playing Pbinds automatically

(
~pbplay = { | ... durs |
	var event, process, duration;
	//{
		durs do: { | what, i |
			#duration, event = what.asArray;
			postf("playing % for: %\n", event, duration);
			process = event.play;
			duration.wait;
			process.stop;
		};
		"DONE".postln;
	//}.fork;
};
)

/*
https://stackoverflow.com/questions/31482726/what-is-the-simplest-way-to-play-a-sample-tone-with-given-tempo-in-supercollider
*/

// Metronome + Recording of Metronome

(
{
Server.default.record;

2.wait;

~bpm = 60;
x = {SinOsc.ar * Pulse.ar(~bpm/60, 0.01).lag}.play;

(8*60). wait;

Server.default.stopRecording;
}.fork;
)


//Playing + recording supercollider's score


(
{
Server.default.record;
1.wait;
(7*4).wait;


~pbplay.( // apodomisis' code score , total duration 440 seconds, including the line 190 of wait.
	[4*7, Pbind(\instrument, "Flute1", \dur, 1, \vibrato, Prand([0.01,3],inf), \note, Pseq([1, 5, \, 11, 8, 2, 0, 10, \, 7, 3, 9, 6, 4], 2), \amp, 0.2)], //first section of the piece, normal sound of flute, thus Flute 1 Synth
	8, // pause between phrases. If no pattern is provided, then stay silent.
	[20.5, Pbind(\instrument, "Flute1",\note, Pseq([ \, 25, 29, 35, \, 32, 26, 24, \, 34, 35, 26, 33, 30, 28]),
			\dur,  Pseq([ 1, 1.5, 1/2, 1.5, 1, 1.5, 1/2, 1.5, 1, 3, 2, 2, 1.5, 1/2, 1.5]),\amp, 0.4)],
	0.5, // pause m.22 1st tactus
	[1, Pbind(\instrument, "Flute1", \dur, 1/6, \vibrato, 1, \note, Pseq([28,18, 21, 27, 19, 22]),\amp, 0.2)],
	1,	// pause m.22 3rd tactus
	[1, Pbind(\instrument, "Flute1", \dur, 1/6,\vibrato, 1, \note, Pseq([22,19, 27, 21, 18, 28]),\amp, 0.2)],
	1, // pause m.23 1st tactus
	[1, Pbind(\instrument, "Flute1", \dur, 1/6, \vibrato, 1,\note, Pseq([28,18, 21, 27, 19, 22]),\amp, 0.3)],
	1, //pause m.23 3rd tactus
	[1, Pbind(\instrument, "Flute1", \dur, 1/6,\note, Pseq([22,19, 27, 21, 18, 28]),\amp, 0.3)],
	[4*2, Pbind(\instrument, "Flute1", \dur, 1/6,\note, Pseq([28,18, 21, 27, 19, 22, 24, 26, 20, 23, 17, 25], 4),\amp, 0.4)],
	[4, Pbind(\instrument, "Flute1", \dur, 1/6,\note, Pseq([16, 6, 9, 15, 7, 10, 12, 14, 8, 11, 5, 13], 2),\amp, 0.3)],
	[4, Pbind(\instrument, "Flute1", \dur, 1/3,\note, Pseq([16, 6, 9, 15, 7, 10, 12, 14, 8, 11, 5, 13]),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute1", \dur, 1/3,\note, Pseq([4, 6, 9, 15, 7, 10, 12, 2, 8, 11, 5, 13]),\amp, 0.1)],
	[4*3, Pbind(\instrument, "Flute1", \vibrato, Prand([0.01,3],inf), \note, Pseq([ \, 11, 5, 13, \, -1, 5, 1, \, 8, -1, 5, 1, \, 4, 4, 4, 4]),
			\dur,  Pseq([ 1, 1/3, 1/3, 1/3, 1, 1/3, 1/3, 1/3, 1.5, 1/2, 1/3, 1/3, 1/3, 1.5, 1, 1, 1, 1/2]),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute2", \dur, 1,\note, Pseq([16, 16, 16, 16]),\amp, 0.15)],
		// second section of the piece, thus Flute 2 Synth
	[9, Pbind(\instrument, "Flute2", \note, Pseq([ \, 25, 21, 27, \, 25, 21, 27, \]),
			\dur,  Pseq([ 1.5, 1.5, 1/2, 1.5, 1/2, 1.5, 1/2, 1.5, 1/2]),\amp, 0.15)],
	[19.5, Pbind(\instrument, "Flute2", \note, Pseq([ 25, 21, 27, \, 28, 24, 26, \, 28, 31, 35, 29, 32, 34]),
			\dur,  Pseq([ 1.5, 1/2, 1.5, 1, 1.5, 1/2, 1.5, 1, 3, 2, 2, 1.5, 1/2, 1.5]),\amp, 0.2)],
	[19.5, Pbind(\instrument, "Flute2", \note, Pseq([ 34, 32, 29, 35, 31, 28, \, 26, 24, 28, \, 27, 21, 25]),
			\dur,  Pseq([ 1.5, 1/2, 1.5, 2, 2, 3, 1, 1.5, 1/2, 1.5, 1, 1.5, 1/2, 1.5]),\amp, 0.2)],
	[4*3, Pbind(\instrument, "Flute2", \dur, 1/6,\note, Pseq([26, 24, 18, 15, 21, 24], 12),\amp, 0.15)],
	[4*3, Pbind(\instrument, "Flute2", \dur, 1/6,\note, Pseq([26, 24, 18, 15, 9, 1, 1, 9, 15, 18, 24, 26], 6),\amp, 0.2)],
	[4*3, Pbind(\instrument, "Flute2", \dur, 1/6,\note, Pseq([28, 31, 35, 29, 32, 34], 12),\amp, 0.3)],
	[4*3, Pbind(\instrument, "Flute2", \dur, 1/6,\note, Pseq([34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 9, 1], 6),\amp, 0.2)],
	[4*3, Pbind(\instrument, "Flute2", \dur, 1/6,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34], 6),\amp, 0.2)],
	[4*2, Pbind(\instrument, "Flute3", \dur, 1,\note, Pseq([34, 34, 34, 34], 2),\amp, 0.2)],
		// third section of the piece, thus Flute 3 Synth
	[4*2, Pbind(\instrument, "Flute3", \dur, 1,\note, Pseq([21, 21, 21, 21], 2),\amp, 0.3)],
	[4*3, Pbind(\instrument, "Flute3", \dur, 1,\note, Pseq([7, 7, 7, 7], 3),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute1", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4], 2),\amp, 0.2)],
        [4, Pbind(\instrument, "Flute2", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute1", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 9, 1], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute2", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 9, 1], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 9, 1], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute1", \dur, 1/12,\note, Pseq([37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4, 4, 6, 9, 3, 7, 10, 12, 14, 20, 23, 29, 37], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute2", \dur, 1/12,\note, Pseq([37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4, 4, 6, 9, 3, 7, 10, 12, 14, 20, 23, 29, 37], 2),\amp, 0.2)],
	[4, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4, 4, 6, 9, 3, 7, 10, 12, 14, 20, 23, 29, 37], 2),\amp, 0.2)],
	[4*2, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([37, 29, 23, 20, 14, 12, 10, 7, 3, 9, 6, 4], 8),\amp, 0.2)],
	[4*2, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([4, 6, 9, 3, 7, 10, 12, 14, 20, 23, 29, 37], 8),\amp, 0.2)],
	[4*2, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 9, 1], 8),\amp, 0.2)],
	[4*2, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([1, 9, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34], 8),\amp, 0.2)],
	[4*3, Pbind(\instrument, "Flute3", \dur, 1/12,\note, Pseq([25, 29, 35, 32, 26, 24, 34, 31, 27, 33, 30, 28, 28, 30, 33, 27, 31, 34, 24, 26, 32, 35, 29, 25, 25, 21, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 21, 25], 3),\amp, 0.4)],
	[4*2, Pbind(\instrument, "Flute3", \dur, 1/6,\note, Pseq([25, 29, 35, 32, 26, 24, 34, 31, 27, 33, 30, 28, 28, 30, 33, 27, 31, 34, 24, 26, 32, 35, 29, 25, 25, 21, 15, 18, 24, 26, 28, 31, 35, 29, 32, 34, 34, 32, 29, 35, 31, 28, 26, 24, 18, 15, 21, 25]),\amp, 0.4)],
	[4*3, Pbind(\instrument, "Flute3", \dur, 1/4,\note, Pseq([13, 17, 23, 20, 14, 12, 22, 19, 15, 21, 18, 16, 16, 18, 21, 15, 19, 22, 12, 14, 20, 23, 17, 13, 13, 9, 3, 6, 12, 14, 16, 19, 23, 17, 20, 22, 22, 20, 17, 23, 19, 16, 14, 12, 6, 3, 9, 13]),\amp, 0.3)],
	[4*4, Pbind(\instrument, "Flute3", \dur, 1/3,\note, Pseq([13, 17, 23, 20, 14, 12, 22, 19, 15, 21, 18, 16, 16, 18, 21, 15, 19, 22, 12, 14, 20, 23, 17, 13, 13, 9, 3, 6, 12, 14, 16, 19, 23, 17, 20, 22, 22, 20, 17, 23, 19, 16, 14, 12, 6, 3, 9, 13]),\amp, 0.3)],
	[4*6, Pbind(\instrument, "Flute3", \dur, 1/2,\note, Pseq([1, 5, 11, 8, 2, 0, 11, 7, 3, 9, 6, 4, 4, 6, 9, 3, 7, 11, 0, 2, 8, 11, 5, 1, 1, -3, -9, -6, 0, 2, 4, 7, 11, 5, 8, 10, 10, 8, 5, 11, 7, 4, 2, 0, -6, -9, -3, 1]),\amp, 0.2)],
	[4*12, Pbind(\instrument, "Flute3", \dur, 1,\note, Pseq([1, 5, 11, 8, 2, 0, 11, 7, 3, 9, 6, 4, 4, 6, 9, 3, 7, 11, 0, 2, 8, 11, 5, 1, 1, -3, -9, -6, 0, 2, 4, 7, 11, 5, 8, 10, 10, 8, 5, 11, 7, 4, 2, 0, -6, -9, -3, 1]),\amp, 0.2)],
	[4*2, Pbind(\instrument, "Flute3", \note, Pseq([1, 1, 1, 1, 1, \]),\dur,  Pseq([ 1, 1, 1, 1, 3, 1]),\amp, 0.1)]

);


8.wait;

Server.default.stopRecording;
}.fork;
)

