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
		'bias'
	],
	#category : #NeuralNetwork
}

{ #category : #accessing }
Neuron >> bias [
	"Return the bias of the neuron."
	^ bias
]

{ #category : #accessing }
Neuron >> bias: aNumber [
	"Set the bias of the neuron."
	bias := aNumber
]

{ #category : #actions }
Neuron >> feed: inputs [
	| z |
	z := (inputs with: weigths collect: [:x :w | x * w ]) sum + bias.
	^ z > 0 ifTrue: [ 1 ] ifFalse: [ 0 ].
]

{ #category : #accessing }
Neuron >> weights [
	"Return the weights of the neuron."
	^ weigths
]

{ #category : #accessing }
Neuron >> weights: someWeightsAsNumbers [
	"Set the weights of the neuron. Takes a collection of numbers as argument."
	weigths := someWeightsAsNumbers
]
