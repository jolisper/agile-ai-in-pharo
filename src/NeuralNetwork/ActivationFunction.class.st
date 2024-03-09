"
I represent an activation function used in neural networks.
I compute the activation value and its derivative, essential for training and learning algorithms such as backpropagation.
I provide a base for implementing specific activation functions, allowing for extensibility and flexibility in neural network designs.

Collaborators:
My main collaborators are the Neuron and NeuralNetwork classes. I interact with them by providing the activation function used to compute the output of a neuron or a layer in a neural network.

Public API and Key Messages:
- `eval:`: Computes the activation value for a given input.
- `derivative:`: Computes the derivative of the activation function for a given output.

Internal Representation and Key Implementation Points:
- The implementation of `eval:` and `derivative:` methods varies depending on the specific activation function being implemented.
- Subclasses of ActivationFunction must implement the `eval:` and `derivative:` methods to provide the behavior of the specific activation function.
"
Class {
	#name : #ActivationFunction,
	#superclass : #Object,
	#category : #NeuralNetwork
}

{ #category : #compute }
ActivationFunction >> derivative: output [
	"Derivative acts as a sensitivity regulator, ensuring that the impact of the activation function's output on the learning 	process is appropriately scaled based on the steepness of the activation function at the given input value."
	
	^ self subclassResponsibility 
]

{ #category : #compute }
ActivationFunction >> eval: z [
	^ self subclassResponsibility 
]
