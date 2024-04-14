Class {
	#name : #PerceptronTest,
	#superclass : #TestCase,
	#category : #'NeuralNetwork-Tests'
}

{ #category : #'instance creation' }
PerceptronTest >> digitalComparator: inputs [
	"Return an array of three elements with the result of comparing the first and second inputs elements: A > B, A = B, A < B"
	| not and nor a b aGb aEb aLb notA notB |
	a := inputs first.
	b := inputs second.
	
	not := self newNeuronWithWeights: #(-1) bias: 0.5.
	and := self newNeuronWithWeights: #(1 1) bias: -1.5.
	nor := self newNeuronWithWeights: #(-1 -1) bias: 0.5.

	notA := not feed: { a }.
	notB := not feed: { b }.
	
	aLb := and feed: { notA . b }.
	aGb := and feed: { a . notB }.
	aEb := nor feed: { aGb . aLb }.
	
	^ { aGb . aEb . aLb }
]

{ #category : #'instance creation' }
PerceptronTest >> newNeuronWithWeights: aWeights bias: aBias [
	"Return a new neuron"
	^ (Neuron newWithWeights: aWeights bias: aBias) step 
]

{ #category : #'instance creation' }
PerceptronTest >> testAND [
	| p |
	p := self newNeuronWithWeights: #(1 1) bias: -1.5.
	
	self assert: (p feed: #(0 0)) equals: 0.
	self assert: (p feed: #(0 1)) equals: 0.
	self assert: (p feed: #(1 0)) equals: 0.
	self assert: (p feed: #(1 1)) equals: 1.
]

{ #category : #'instance creation' }
PerceptronTest >> testDigitalComparator [

	self assert: (self digitalComparator: #(0 0)) equals: #(0 1 0).
	self assert: (self digitalComparator: #(1 0)) equals: #(1 0 0).
	self assert: (self digitalComparator: #(0 1)) equals: #(0 0 1).
	self assert: (self digitalComparator: #(1 1)) equals: #(0 1 0).
]

{ #category : #'instance creation' }
PerceptronTest >> testMustReturnOne [
	| p result |
	p := self newNeuronWithWeights: #(2 3) bias: -12.
	result := p feed: #(2 3).
	self assert: result equals: 1.

]

{ #category : #'instance creation' }
PerceptronTest >> testMustReturnZero [
	| p result |
	p := self newNeuronWithWeights: #(2 3) bias: -12.
	result := p feed: #(2 3).
	self assert: result equals: 1.

]

{ #category : #'instance creation' }
PerceptronTest >> testNOR [
	| p |
	p := self newNeuronWithWeights: #(-1 -1) bias: 0.5.
	
	self assert: (p feed: #(0 0)) equals: 1.
	self assert: (p feed: #(0 1)) equals: 0.
	self assert: (p feed: #(1 0)) equals: 0.
	self assert: (p feed: #(1 1)) equals: 0.
]

{ #category : #'instance creation' }
PerceptronTest >> testNOT [
	| p |
	p := self newNeuronWithWeights: #(-1) bias: 0.5.
	
	self assert: (p feed: #(1)) equals: 0.
	self assert: (p feed: #(0)) equals: 1.
	
]

{ #category : #'instance creation' }
PerceptronTest >> testOR [
	| p |
	p := self newNeuronWithWeights: #(1 1) bias: -0.5.
	
	self assert: (p feed: #(0 0)) equals: 0.
	self assert: (p feed: #(0 1)) equals: 1.
	self assert: (p feed: #(1 0)) equals: 1.
	self assert: (p feed: #(1 1)) equals: 1.
]

{ #category : #'instance creation' }
PerceptronTest >> testSmallExample [
	| p result |
	p := self newNeuronWithWeights: #(1 2) bias: -2.
	result := p feed: #(5 2).
	self assert: result equals: 1.
	
	p := self newNeuronWithWeights: #(-2 2) bias: -2.
	result := p feed: #(5 2).
	self assert: result equals: 0.
]

{ #category : #'instance creation' }
PerceptronTest >> testTrainingAND [
	| p |
	p := self newNeuronWithWeights: {-1 . -1} bias: 2.
	
	25 timesRepeat: [
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 0.
		p train: #(1 0) desiredOutput: 0.
		p train: #(1 1) desiredOutput: 1.
	].
	
	self assert: (p feed: #(0 0)) equals: 0.
	self assert: (p feed: #(0 1)) equals: 0.
	self assert: (p feed: #(1 0)) equals: 0.
	self assert: (p feed: #(1 1)) equals: 1.
	
	
	
	
	

]

{ #category : #'instance creation' }
PerceptronTest >> testTrainingNOR [
	| p |
	p := self newNeuronWithWeights: {-1 . -1} bias: 2.
	
	32 timesRepeat: [
		p train: #(0 0) desiredOutput: 1.
		p train: #(0 1) desiredOutput: 0.
		p train: #(1 0) desiredOutput: 0.
		p train: #(1 1) desiredOutput: 0.
	].
	
	self assert: (p feed: #(0 0)) equals: 1.
	self assert: (p feed: #(0 1)) equals: 0.
	self assert: (p feed: #(1 0)) equals: 0.
	self assert: (p feed: #(1 1)) equals: 0.
]

{ #category : #'instance creation' }
PerceptronTest >> testTrainingNOT [
	| p |
	p := self newNeuronWithWeights: {-1} bias: 2.
	
	5 timesRepeat: [ 
		p train: #(0) desiredOutput: 1.
		p train: #(1) desiredOutput: 0.
	].
	
	self assert: (p feed: #(0)) equals: 1.
	self assert: (p feed: #(1)) equals: 0.
]

{ #category : #'instance creation' }
PerceptronTest >> testTrainingOR [
	| p |
	p := self newNeuronWithWeights: {-1 . -1} bias: 2.
	
	32 timesRepeat: [
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 1.
		p train: #(1 0) desiredOutput: 1.
		p train: #(1 1) desiredOutput: 1.
	].
	
	self assert: (p feed: #(0 0)) equals: 0.
	self assert: (p feed: #(0 1)) equals: 1.
	self assert: (p feed: #(1 0)) equals: 1.
	self assert: (p feed: #(1 1)) equals: 1.
	
	
	
	
	

]

{ #category : #'instance creation' }
PerceptronTest >> testTrainingXOR [
	"Training a single-layer perceptron to learn the XOR (exclusive OR) function is not possible due to the linear separability of the XOR problem. The XOR function is not linearly separable, meaning a single hyperplane cannot separate the two classes (0 and 1) in the input space. 

Here's why a single-layer perceptron cannot learn the XOR function:

1. **Linear Separability**: A single-layer perceptron uses a linear activation function, which means it can only learn linearly separable patterns. In the case of the XOR function, the input space cannot be separated by a single straight line or hyperplane.

2. **XOR Truth Table**: The XOR function outputs 1 only when the inputs are different (0 XOR 1 or 1 XOR 0), and outputs 0 when the inputs are the same (0 XOR 0 or 1 XOR 1). This behavior cannot be captured by a single linear decision boundary.

3. **Perceptron Learning Rule**: The perceptron learning rule adjusts the weights based on misclassifications, but for the XOR function, there is no single linear decision boundary that can correctly classify all four input combinations.

To solve the XOR problem, more complex models such as multi-layer perceptrons (neural networks with hidden layers) or other non-linear classifiers like support vector machines or decision trees can be used. These models have the capacity to learn non-linear decision boundaries and can successfully learn the XOR function.

In summary, a single-layer perceptron cannot learn the XOR function due to its linear separability, and more complex models are required to solve non-linear classification problems like XOR."

	| p |
	p := self newNeuronWithWeights: {-1 . -1} bias: 2.
	1000
		timesRepeat: [ 
			p train: #(0 0) desiredOutput: 0.
			p train: #(0 1) desiredOutput: 1.
			p train: #(1 0) desiredOutput: 1.
			p train: #(1 1) desiredOutput: 0 ].
		
	"
	self assert: (p feed: #(0 0)) equals: 0. 
	self assert: (p feed: #(0 1)) equals: 1.
	self assert: (p feed: #(1 0)) equals: 1. 
	self assert: (p feed: #(1 1)) equals: 0.
	"
]

{ #category : #'instance creation' }
PerceptronTest >> testWrongFeeding [
	| p |
	p := self newNeuronWithWeights: #(-1) bias: 0.5.
	
	self should: [ p feed: #(1 1) ] raise: Error.

]
