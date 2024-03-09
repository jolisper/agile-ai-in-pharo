"
I represent the step function used as an activation function in neural networks.
I compute the activation value based on a given input, producing a binary output.
I provide a base for implementing the step function, allowing for its integration into neural network architectures.

Collaborators:
My main collaborators are the Neuron and NeuralNetwork classes. I interact with them by providing the step function used to compute the output of a neuron or a layer in a neural network.

Public API and Key Messages:
- `eval:`: Computes the activation value (binary output) for a given input.
- `derivative:`: Placeholder method for the derivative of the step function.
- `new`: Factory method to create instances of the StepFunction class.

Internal Representation and Key Implementation Points:
- The implementation of the `eval:` method involves producing a binary output based on the input.
- The derivative of the step function is not applicable, as it is not differentiable at certain points.
"
Class {
	#name : #StepAF,
	#superclass : #ActivationFunction,
	#category : #NeuralNetwork
}

{ #category : #compute }
StepAF >> derivative: output [
	^ 1
]

{ #category : #compute }
StepAF >> eval: z [
	^ (z > 0) ifTrue: [ 1 ] ifFalse: [ 0 ]
]
