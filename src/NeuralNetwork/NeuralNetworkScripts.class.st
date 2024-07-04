Class {
	#name : #NeuralNetworkScripts,
	#superclass : #Object,
	#category : #NeuralNetwork
}

{ #category : #script }
NeuralNetworkScripts class >> activationFunctionSigmoid [
| g d |
g := RTGrapher new.
d := RTData new.

d connectColor: Color blue.
d noDot.

d points: (-7.0 to: 7.0 by: 0.01).
d x: #yourself.
d y: [ :x | 1 / (1 + (x negated exp)) ].
g add: d.
^ g
]

{ #category : #script }
NeuralNetworkScripts class >> activationFunctionStep [
| g d |
g := RTGrapher new.
d := RTData new.

d connectColor: Color blue.
d noDot.

d points: (-7.0 to: 7.0 by: 0.01).
d x: #yourself.
d y: [ :x | x > 0 ifTrue: [ 1 ] ifFalse: [ 0 ] ].
g add: d.
^ g
]

{ #category : #script }
NeuralNetworkScripts class >> measuringThePrecision [
| learningCurve f r p anX anY trainedOutput nbOfGood nbOfTries realOutput g d |
learningCurve := OrderedCollection new.

f := [ :x | (-2 * x) - 3 ].

0 to: 2000 by: 10 do: [ :nbOfTrained | 
	r := Random new seed: 42.
	p := Neuron newWithWeights: #(1 2) bias: -1. 

	nbOfTrained timesRepeat: [
		anX := (r nextInt: 50) - 25.
		anY := (r nextInt: 50) - 25.
		trainedOutput := (f value: anX) >= anY ifTrue: [ 1 ] ifFalse: [ 0 ].
		p train: (Array with: anX with: anY) desiredOutput: trainedOutput
	].

	nbOfGood := 0.
	nbOfTries := 1000.
	nbOfTries timesRepeat: [
		anX := (r nextInt: 50) - 25.
		anY := (r nextInt: 50) - 25.
		realOutput := (f value: anX) >= anY ifTrue: [ 1 ] ifFalse: [ 0 ].
		((p feed: { anX . anY }) - realOutput) abs < 0.2 ifTrue: [ nbOfGood := nbOfGood + 1 ].
	].
	learningCurve add: { nbOfTrained . (nbOfGood / nbOfTries) }.
].

g := RTGrapher new.
d := RTData new.
d noDot.
d connectColor: Color blue.
d points: learningCurve.
d x: #first.
d y: #second.
g add: d.
g axisY title: 'Precision'.
g axisX noDecimal; title: 'Training iteration'.
^ g
]

{ #category : #script }
NeuralNetworkScripts class >> perceptronVsSigmoidNeuronLearningVelocity [ 
		| learningCurveNeuron p res learningCurvePerceptron g d |
	learningCurveNeuron := OrderedCollection new.
0 to: 1000 do: [ :nbOfTrained | 
	p := Neuron newWithWeights: #(-1 -1) bias: 2.
	
	nbOfTrained timesRepeat: [ 
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 0.
		p train: #(1 0) desiredOutput: 0.
		p train: #(1 1) desiredOutput: 1 ].
	
	res := 
		((p feed: #(0 0)) - 0) abs +
		((p feed: #(0 1)) - 0) abs +
		((p feed: #(0 1)) - 0) abs +
		((p feed: #(0 1)) - 0) abs.
		
	learningCurveNeuron add: res / 4.
].

learningCurvePerceptron := OrderedCollection new.
0 to: 1000 do: [ :nbOfTrained | 
	p := Neuron newWithWeights: #(-1 -1) bias: 2.
	p step.
	
	nbOfTrained timesRepeat: [ 
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 0.
		p train: #(1 0) desiredOutput: 0.
		p train: #(1 1) desiredOutput: 1 ].
	
	res := 
		((p feed: #(0 0)) - 0) abs +
		((p feed: #(0 1)) - 0) abs +
		((p feed: #(0 1)) - 0) abs +
		((p feed: #(0 1)) - 0) abs.
		
	learningCurvePerceptron add: res / 4.
].

g := RTGrapher new.
d := RTData new.
d label: 'Sigmoid neuron'.
d noDot.
d connectColor: Color blue.
d points: learningCurveNeuron.
d y: #yourself.
g add: d.
d := RTData new.
d label: 'Perceptron'.
d noDot.
d connectColor: Color green.
d points: learningCurvePerceptron.
d y: #yourself.
g add: d.

g axisY title: 'Error'.
g axisX noDecimal; title: 'Epoch'.
g legend addText: 'Perceptron vs Sigmoid neuron'.
^g
]

{ #category : #script }
NeuralNetworkScripts class >> predictingAnd2DPoints [
	| f p r trainPoints anX anY desiredOutput testPoints g d d2 |
	f := [ :x | -2 * x - 3 ].
	p := Neuron newWithWeights: {1 . 2} bias: -1.

	"A random number generator"
	r := Random new seed: 42.

	"Training input"
	trainPoints := OrderedCollection new.
	2000
		timesRepeat: [ anX := (r nextInt: 50) - 25.
			anY := (r nextInt: 50) - 25.
			desiredOutput := (f value: anX) > anY
				ifTrue: [ 1 ]
				ifFalse: [ 0 ].
			trainPoints
				add:
					{anX.
					anY.
					desiredOutput} ].

	"Training the perceptron"
	trainPoints
		do: [ :each | 
			anX := each at: 1.
			anY := each at: 2.
			desiredOutput := each at: 3.
			p
				train:
					{anX.
					anY}
				desiredOutput: desiredOutput ].

	"Test points"
	testPoints := OrderedCollection new.
	2000
		timesRepeat: [ testPoints
				add:
					{((r nextInt: 50) - 25).
					((r nextInt: 50) - 25)} ].

	"Plot the result "
	g := RTGrapher new.
	d := RTData new.
	d dotShape
		color: [ :point | 
			(p feed: point) > 0.5
				ifTrue: [ Color red trans ]
				ifFalse: [ Color blue trans ] ].
	d points: testPoints.
	d x: #first.
	d y: #second.
	g add: d.

	"Plot"
	d2 := RTData new.
	d2 noDot.
	d2 connectColor: Color red.
	d2 points: (-15 to: 15 by: 0.1).
	d2 y: f.
	d2 x: #yourself.
	g add: d2.
	^ g
]
