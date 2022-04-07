Class {
	#name : #GtMagritteCompletionStrategyStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'memento',
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - instantiation' }
GtMagritteCompletionStrategyStencilBuilder >> buildDefault [

	<return: #GtStreamedCompletionStrategy or: nil>
	^ nil
]

{ #category : #accessing }
GtMagritteCompletionStrategyStencilBuilder >> description [

	^ description
]

{ #category : #accessing }
GtMagritteCompletionStrategyStencilBuilder >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteCompletionStrategyStencilBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteCompletionStrategyStencilBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - instantiation' }
GtMagritteCompletionStrategyStencilBuilder >> paramsOn: aStencilExecutor [

	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self memento;
		push: self description
]

{ #category : #initialization }
GtMagritteCompletionStrategyStencilBuilder >> reset [

	super reset.
	self memento: nil.
	self description: nil.

]
