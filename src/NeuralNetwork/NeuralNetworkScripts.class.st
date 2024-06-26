Class {
	#name : #NeuralNetworkScripts,
	#superclass : #Object,
	#category : #NeuralNetwork
}

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
