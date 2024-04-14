Class {
	#name : #NeuronTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #tests }
NeuronTest >> testTrainingAND [
	| p |
	p := Neuron newWithWeights: {-1 . -1} bias: 2.
	
	5000 timesRepeat: [
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 0.
		p train: #(1 0) desiredOutput: 0.
		p train: #(1 1) desiredOutput: 1.
	].
	
	self assert: ((p feed: #(0 0)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(0 1)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(1 0)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(1 1)) closeTo: 1 precision: 0.1).
	
]

{ #category : #tests }
NeuronTest >> testTrainingNAND [
	| p |
	p := Neuron newWithWeights: {-1 . -1} bias: 2.
	
	5000 timesRepeat: [
		p train: #(0 0) desiredOutput: 1.
		p train: #(0 1) desiredOutput: 1.
		p train: #(1 0) desiredOutput: 1.
		p train: #(1 1) desiredOutput: 0.
	].
	
	self assert: ((p feed: #(0 0)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(0 1)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1 0)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1 1)) closeTo: 0 precision: 0.1).
	
]

{ #category : #tests }
NeuronTest >> testTrainingNOR [
	| p |
	p := Neuron newWithWeights: {-1 . -1 } bias: 2.
	
	5000 timesRepeat: [ 
		p train: #(0 0) desiredOutput: 1.
		p train: #(0 1) desiredOutput: 0.
		p train: #(1 0) desiredOutput: 0.
		p train: #(1 1) desiredOutput: 0.
	].
	
	self assert: ((p feed: #(0 0)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(0 1)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(1 0)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(1 1)) closeTo: 0 precision: 0.1).
]

{ #category : #tests }
NeuronTest >> testTrainingNOT [
	| p |
	p := Neuron newWithWeights: {-1} bias: 2.
	
	5000 timesRepeat: [ 
		p train: #(0) desiredOutput: 1.
		p train: #(1) desiredOutput: 0.
	].
	
	self assert: ((p feed: #(0)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1)) closeTo: 0 precision: 0.1).
]

{ #category : #tests }
NeuronTest >> testTrainingOR [
	| p |
	p := Neuron newWithWeights: {-1 . -1} bias: 2.
	
	5000 timesRepeat: [
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 1.
		p train: #(1 0) desiredOutput: 1.
		p train: #(1 1) desiredOutput: 1.
	].
	
	self assert: ((p feed: #(0 0)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(0 1)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1 0)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1 1)) closeTo: 1 precision: 0.1).
	
]

{ #category : #tests }
NeuronTest >> testTrainingXOR [
	"Training a single sigmoid neuron to learn the XOR (exclusive OR) behavior is not possible due to the same limitations that apply to a single-layer perceptron. The XOR function is not linearly separable, and a single neuron, whether using a sigmoid activation function or any other non-linear activation function, cannot learn XOR with a single decision boundary.

Here's why training a single sigmoid neuron to learn XOR behavior is not feasible:

1. **Linear Separability**: The XOR function requires a non-linear decision boundary to separate the input space into the correct output classes. A single neuron, even with a sigmoid activation function, can only produce a linear decision boundary, which is insufficient to represent the XOR function.

2. **Activation Function**: While the sigmoid activation function introduces non-linearity, it is still limited by the single neuron's inability to capture the XOR behavior with a single decision boundary.

3. **Complexity of XOR**: The XOR function's behavior (outputting 1 only when inputs are different) cannot be captured by a single neuron's weighted sum and activation function. The XOR problem requires a more complex model with multiple layers or non-linear interactions to learn the correct mapping.

To successfully learn the XOR function, a neural network with at least one hidden layer is needed to introduce the necessary non-linear transformations and capture the XOR behavior. By using multiple neurons and appropriate connections, a neural network can learn the XOR function effectively.

In summary, training a single sigmoid neuron to learn the XOR behavior is not feasible due to the XOR problem's non-linear nature and the limitations of a single neuron in capturing complex non-linear patterns like XOR.
"

	| p |
	p := Neuron newWithWeights: {-1 . -1} bias: 2.
	5000
		timesRepeat: [ 
			p train: #(0 0) desiredOutput: 0.
			p train: #(0 1) desiredOutput: 1.
			p train: #(1 0) desiredOutput: 1.
			p train: #(1 1) desiredOutput: 0 ].
		
	" 
	self assert: ((p feed: #(0 0)) closeTo: 0 precision: 0.1).
	self assert: ((p feed: #(0 1)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1 0)) closeTo: 1 precision: 0.1).
	self assert: ((p feed: #(1 1)) closeTo: 1 precision: 0.1)
	"	
	
	
]
