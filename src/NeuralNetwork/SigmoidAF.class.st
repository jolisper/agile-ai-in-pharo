"
I represent the sigmoid activation function used in neural networks.

Responsibility:
My main responsibilities are computing the activation value and its derivative using the sigmoid function, essential for training and learning algorithms such as backpropagation. I provide a base for implementing the sigmoid function, allowing for its integration into neural network architectures.

Collaborators:
My main collaborators are the Neuron and NeuralNetwork classes. I interact with them by providing the sigmoid function used to compute the output of a neuron or a layer in a neural network.

Public API and Key Messages:
- `eval:`: Computes the activation value for a given input using the sigmoid function.
- `derivative:`: Computes the derivative of the sigmoid function for a given output.

Comparison with StepFunction:
Compared to the StepFunction, the SigmoidAF produces a continuous output between 0 and 1 based on the input, allowing for a smooth transition between the two extremes. This continuous nature of the sigmoid function enables more nuanced and gradual adjustments in the output, which can be advantageous for certain types of learning and optimization processes in neural networks. Additionally, the derivative of the sigmoid function is differentiable at all points, unlike the StepFunction, which is not differentiable at certain points. This differentiability is important for backpropagation and other learning algorithms that rely on computing the derivative of the activation function.

"
Class {
	#name : #SigmoidAF,
	#superclass : #ActivationFunction,
	#category : #NeuralNetwork
}

{ #category : #compute }
SigmoidAF >> derivative: output [
	^ output * (1 - output)
]

{ #category : #compute }
SigmoidAF >> eval: z [
	^ 1 / (1 + z negated exp)
]
