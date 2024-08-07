"
I represent a neuron of a neural network.

A neuron receives a stimulus as input (feed method) and responds to that stimulus by producing as output value. The output obeys a very simple rule: if the sum of the weighted inputs is above a particular given value (bias), then the neuron fires 1; otherwise, it fires 0.

Public API and Key Messages

- weights: method receives an array of weights values.
- bias: receives a number bias.
- feed: receives the input stimulus.

p := Neuron new.
p weights: #(1 2).
p bias: -2.
p feed: #(5 2). ""Returns 1""

"
Class {
	#name : #Neuron,
	#superclass : #Object,
	#instVars : [
		'weights',
		'bias',
		'learningRate',
		'activationFunction',
		'delta',
		'output'
	],
	#category : #NeuralNetwork
}

{ #category : #'instance creation' }
Neuron class >> newWithWeights: aWeights bias: aBias [ 
	^ self new initializeWithWeights: aWeights bias: aBias
]

{ #category : #actions }
Neuron >> adjustBias [
	bias := bias + (learningRate * delta)
]

{ #category : #actions }
Neuron >> adjustDeltaWith: anError [
	delta := anError * (activationFunction derivative: output )
]

{ #category : #actions }
Neuron >> adjustWeightWithInput: inputs [
	inputs withIndexDo: [ :anInput :index |
		weights at: index put: ((weights at: index) + (learningRate * delta * anInput))]
]

{ #category : #accesing }
Neuron >> bias [
	"Return the bias of the neuron."
	^ bias
]

{ #category : #accesing }
Neuron >> bias: aBias [ 
	bias := aBias
]

{ #category : #accesing }
Neuron >> delta [ 
"Return the delta value computed when propagating the error"
^delta
]

{ #category : #actions }
Neuron >> feed: inputs [
	| z |
	z := (inputs with: weights collect: [ :x :w | x * w ]) sum + bias.
	output := activationFunction eval: z.
	^ output
]

{ #category : #initialization }
Neuron >> initialize [ 
	super initialize.
	learningRate := 0.1.
	self sigmoid
]

{ #category : #initialization }
Neuron >> initializeWithWeights: aWeights bias: aBias [
	self initialize.
	weights := aWeights.
	bias := aBias
]

{ #category : #accesing }
Neuron >> learningRate [
	"Return the learning rate of the neuron."
	^ learningRate 
]

{ #category : #accesing }
Neuron >> learningRate: aLearningRateAsFloat [ 
	"Set the learning rate of the neuron. The argument should be a small floating velue.
	For example , 0.01"
	learningRate := aLearningRateAsFloat
]

{ #category : #actions }
Neuron >> output [
"Return the output value, previous computed when doing a feed:"
^ output 
]

{ #category : #initialization }
Neuron >> sigmoid [
	"Use the sigmoid activation function"
	activationFunction := SigmoidAF new
]

{ #category : #initialization }
Neuron >> step [ 
	"Use the step activation function"
	activationFunction := StepAF new
]

{ #category : #actions }
Neuron >> train: inputs desiredOutput: desiredOutput [
	| diff |
	output := self feed: inputs.
	diff := desiredOutput - output.
	delta := diff * (activationFunction derivative: output).
	inputs
		withIndexDo: [ :anInput :index | 
			weights
				at: index
				put: (weights at: index) + (learningRate * delta * anInput) ].
	bias := bias + (learningRate * delta)
]

{ #category : #accesing }
Neuron >> weights [
	"Return the weights of the neuron."

	^ weights
]

{ #category : #accesing }
Neuron >> weights: aWeights [
	weights := aWeights
]
