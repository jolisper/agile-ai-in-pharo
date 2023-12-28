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
	
	not := self newNeuron weights: #(-1); bias: 0.5.
	and := self newNeuron weights: #(1 1); bias: -1.5.
	nor := self newNeuron weights: #(-1 -1); bias: 0.5.

	notA := not feed: { a }.
	notB := not feed: { b }.
	
	aLb := and feed: { notA . b }.
	aGb := and feed: { a . notB }.
	aEb := nor feed: { aGb . aLb }.
	
	^ { aGb . aEb . aLb }
]

{ #category : #'instance creation' }
PerceptronTest >> newNeuron [
	"Return a new neuron"
	^ Neuron new
]

{ #category : #'instance creation' }
PerceptronTest >> testAND [
	| p |
	p := self newNeuron.
	p weights: #(1 1).
	p bias: -1.5.
	
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
	p := self newNeuron.
	p weights: #(2 3).
	p bias: -12.
	result := p feed: #(2 3).
	self assert: result equals: 1.

]

{ #category : #'instance creation' }
PerceptronTest >> testMustReturnZero [
	| p result |
	p := self newNeuron.
	p weights: #(2 3).
	p bias: -12.
	result := p feed: #(2 3).
	self assert: result equals: 1.

]

{ #category : #'instance creation' }
PerceptronTest >> testNOR [
	| p |
	p := self newNeuron.
	p weights: #(-1 -1).
	p bias: 0.5.
	
	self assert: (p feed: #(0 0)) equals: 1.
	self assert: (p feed: #(0 1)) equals: 0.
	self assert: (p feed: #(1 0)) equals: 0.
	self assert: (p feed: #(1 1)) equals: 0.
]

{ #category : #'instance creation' }
PerceptronTest >> testNOT [
	| p |
	p := self newNeuron.
	p weights: #(-1).
	p bias: 0.5.
	
	self assert: (p feed: #(1)) equals: 0.
	self assert: (p feed: #(0)) equals: 1.
	
]

{ #category : #'instance creation' }
PerceptronTest >> testOR [
	| p |
	p := self newNeuron.
	p weights: #(1 1).
	p bias: -0.5.
	
	self assert: (p feed: #(0 0)) equals: 0.
	self assert: (p feed: #(0 1)) equals: 1.
	self assert: (p feed: #(1 0)) equals: 1.
	self assert: (p feed: #(1 1)) equals: 1.
]

{ #category : #'instance creation' }
PerceptronTest >> testSmallExample [
	| p result |
	p := self newNeuron.
	p weights: #(1 2).
	p bias: -2.
	result := p feed: #(5 2).
	self assert: result equals: 1.
	
	p weights: #(-2 2).
	result := p feed: #(5 2).
	self assert: result equals: 0.
]

{ #category : #'instance creation' }
PerceptronTest >> testWrongFeeding [
	| p |
	p := self newNeuron.
	p weights: #(-1).
	p bias: 0.5.
	
	self should: [ p feed: #(1 1) ] raise: Error.

]
