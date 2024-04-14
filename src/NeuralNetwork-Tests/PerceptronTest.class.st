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
	| p result |
	p := self newNeuronWithWeights: {-1 . -1} bias: 2.
	
	1000 timesRepeat: [
		p train: #(0 0) desiredOutput: 0.
		p train: #(0 1) desiredOutput: 1.
		p train: #(1 0) desiredOutput: 1.
		p train: #(1 1) desiredOutput: 0.
	].
	
	result :=
		((p feed: #(0 0)) = 0) & 
		((p feed: #(0 1)) = 1) &
		((p feed: #(1 0)) = 1) &
		((p feed: #(1 1)) = 0).
	
	self assert: result equals: false.
]

{ #category : #'instance creation' }
PerceptronTest >> testWrongFeeding [
	| p |
	p := self newNeuronWithWeights: #(-1) bias: 0.5.
	
	self should: [ p feed: #(1 1) ] raise: Error.

]
