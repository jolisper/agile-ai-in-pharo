"
We define a layer as a set of neurons. Layers are connected between them, and a set of
layers form a neural network. We will represent a layer with the NeuronLayer class.
"
Class {
	#name : #NeuronLayer,
	#superclass : #Object,
	#instVars : [
		'previousLayer',
		'nextLayer',
		'neurons'
	],
	#category : #NeuralNetwork
}

{ #category : #actions }
NeuronLayer >> backwardPropagateError [
	"This is a recursive method. The backpropagation begins with the 
	output layer (i.e., the last layer)"

	"We are in a hidden layer"

	neurons
		doWithIndex: [ :neuron :j | 
			| theError |
			theError := 0.0.
			self nextLayer neurons
				do:
					[ :nextNeuron | theError := theError + ((nextNeuron weights at: j) * nextNeuron delta) ].
			neuron adjustDeltaWith: theError ].
		
	"We iterate"
	self previousLayer isNotNil
		ifTrue: [ self previousLayer backwardPropagateError ]
]

{ #category : #actions }
NeuronLayer >> backwardPropagateError: expected [
	"This is a recursive method. The backpropagation beghins 
	with the output layer (i.e.,the last layer)"

	"We are in output layer"

	neurons
		with: expected
		do: [ :neuron :exp | 
			"We iterate"
			| theError |
			theError := exp - neuron output.
			neuron adjustDeltaWith: theError ].

	"We iterate"
	self previousLayer isNotNil
		ifTrue: [ self previousLayer backwardPropagateError ]
]

{ #category : #actions }
NeuronLayer >> feed: someInputValues [
	"Feed the neuron layer with some inputs"
	
	| someOutputs |
	someOutputs := neurons collect: [ :n | n feed: someInputValues ] as: Array.
	^ self isOutputLayer
		ifTrue: [ someOutputs ]
		ifFalse: [ nextLayer feed: someOutputs ]
]

{ #category : #initialization }
NeuronLayer >> initializeNbOfNeurons: nbOfNeurons nbOfWeights: nbOfWeights using: random [
	"Main method ot initialize a neuron layer
	nbOfNeurons : number of neurons the layer should be made of
	nbOfWeights : number of weights each neuron should have
	random : a random number generator"

	| weights |
	neurons := (1 to: nbOfNeurons)
		collect: [ :i | 
			weights := (1 to: nbOfWeights) collect: [ :ii | random next * 4 - 2 ].
			Neuron new
				sigmoid;
				weights: weights;
				bias: random next * 4 - 2 ].
	self learningRate: 0.1
]

{ #category : #testing }
NeuronLayer >> isOutputLayer [
	"Return true if the layer is the output layer (i.e., the last layer, 
	right-most, in the network)"

	^ self nextLayer isNil
]

{ #category : #accessing }
NeuronLayer >> learningRate: aLearningRate [
	"Set the learning rate for all the neurons 
	Note that this method should be called after configuring the network,
	and _not_ before"

	self
		assert: [ neurons notEmpty ]
		description: 'learninRate: should be invoked after configuring the layer'.
		neurons do: [ :n | n learningRate: aLearningRate ]
		
	
]

{ #category : #accessing }
NeuronLayer >> neurons [
	"Return the neurons I am composed of"

	^ neurons
]

{ #category : #accessing }
NeuronLayer >> nextLayer [
	"Return the next layer connected to me"
	
^ nextLayer 
]

{ #category : #accessing }
NeuronLayer >> nextLayer: aLayer [
	"Set the next layer"
	nextLayer := aLayer
]

{ #category : #accessing }
NeuronLayer >> numberOfNeurons [
	"Return the number of neurons in the layer"

	^ neurons size
]

{ #category : #accessing }
NeuronLayer >> previousLayer [
	"Return the previous layer connected to me"

	^ previousLayer
]

{ #category : #accessing }
NeuronLayer >> previousLayer: aLayer [
	"Set the previous layer"

	previousLayer := aLayer 
]

{ #category : #accessing }
NeuronLayer >> updateWeight [
	"Update the weights of the neuron based on the set of initial
	input. This method assumes that the receiver of the message
	invoking that method is the first hidden layer.
	We are now in the second hidden layers or in the output layer"

	| inputs |
	inputs := self previousLayer neurons collect: #output.
	self updateWeight: inputs
]

{ #category : #accessing }
NeuronLayer >> updateWeight: initialInputs [ 
	"Update the weights of the neuron based on the set of initial input.
	This method assumes that the receiver of the message invoking that 
	method is the first hidden layer."
	| inputs |
	inputs := initialInputs.
	
	neurons do: [ :n |
		n adjustWeightWithInput: inputs.
		n adjustBias ].
	
	self nextLayer ifNotNil: [ 
		self nextLayer updateWeight ]
]
