"
We define a neural network simply as a container of layers. We also add an errors
instance variable that will be useful for tracing the evolution of error during the
learning phase. The errors and precisions variables will contain numerical values, 
representing the errors and precisions during the training process. 
"
Class {
	#name : #NNetwork,
	#superclass : #Object,
	#instVars : [
		'layers',
		'errors',
		'precisions'
	],
	#category : #NeuralNetwork
}

{ #category : #adding }
NNetwork >> addLayer: aNeuronLayer [
	"Add a neural layer. The added layer is linked to the already added
	layers."

	layers
		ifNotEmpty: [ 
			aNeuronLayer previousLayer: layers last.
			layers last nextLayer: aNeuronLayer ].
	layers add: aNeuronLayer
]

{ #category : #configuration }
NNetwork >> configure: nbOfInputs hidden: nbOfNeurons1 hidden: nbOfNeurons2 nbOfOutputs: nbOfOutput [
	"Configure the network with the given parameters.
	The network has two hidden layers."

	| random |
	random := Random seed: 42.
	self
		addLayer:
			(NeuronLayer new
				initializeNbOfNeurons: nbOfNeurons1
				nbOfWeights: nbOfInputs
				using: random).
	self
		addLayer:
			(NeuronLayer new
				initializeNbOfNeurons: nbOfNeurons2
				nbOfWeights: nbOfNeurons1 
				using: random).
	self
		addLayer:
			(NeuronLayer new
				initializeNbOfNeurons: nbOfOutput
				nbOfWeights: nbOfNeurons2 
				using: random)
]

{ #category : #configuration }
NNetwork >> configure: nbOfInputs hidden: nbOfNeurons nbOfOutputs: nbOfOutput [
	"Configure the network with the given parameters.
	The network has only one hidden layer."

	| random |
	random := Random seed: 42.
	self
		addLayer:
			(NeuronLayer new
				initializeNbOfNeurons: nbOfNeurons
				nbOfWeights: nbOfInputs
				using: random).
	self
		addLayer:
			(NeuronLayer new
				initializeNbOfNeurons: nbOfOutput
				nbOfWeights: nbOfNeurons 
				using: random)
]

{ #category : #actions }
NNetwork >> feed: someInputValues [ 
	"Feed the first layer with the provided inputs"
	^ layers first feed: someInputValues 
]

{ #category : #initialization }
NNetwork >> initialize [
	super initialize.
	layers := OrderedCollection new.
	errors := OrderedCollection new.
	precisions := OrderedCollection new.
]

{ #category : #setter }
NNetwork >> learningRate: aLearningRate [
"Set the learning rate for all the layers"
layers do: [ :l | l learningRate: aLearningRate ]
]

{ #category : #accessing }
NNetwork >> numberOfOutputs [
"Return the number of output of the network"
^ layers last numberOfNeurons 
]
