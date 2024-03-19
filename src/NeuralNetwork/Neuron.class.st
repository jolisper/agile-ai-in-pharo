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
		'weigths',
		'bias',
		'learningRate',
		'activationFunction'
	],
	#category : #NeuralNetwork
}

{ #category : #'instance creation' }
Neuron class >> newWithWeights: aWeights bias: aBias [ 
	^ self new initializeWithWeights: aWeights bias: aBias
]

{ #category : #accessing }
Neuron >> bias [
	"Return the bias of the neuron."
	^ bias
]

{ #category : #actions }
Neuron >> feed: inputs [
	| z |
	z := (inputs with: weigths collect: [:x :w | x * w ]) sum + bias.
	^ activationFunction eval: z
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
	weigths := aWeights.
	bias := aBias.
]

{ #category : #accessing }
Neuron >> learningRate [
	"Return the learning rate of the neuron."
	^ learningRate 
]

{ #category : #accessing }
Neuron >> learningRate: aNumber [
	"Set the learning rate of the neuron."
	learningRate := aNumber 
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
	| diff output delta |
	output := self feed: inputs.
	diff := desiredOutput - output.
	delta := diff * (activationFunction derivative: output).
	
	inputs withIndexDo: [ :anInput :index |
			weigths at: index put: ((weigths at: index) + (learningRate * delta * anInput)) ].
	
	bias := bias + (learningRate * delta)
]

{ #category : #accessing }
Neuron >> weights [
	"Return the weights of the neuron."
	^ weigths
]
