Class {
	#name : #GtMagritteListElementStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'memento',
		'description',
		'form'
	],
	#category : #'GToolkit-Magritte-Core-Support'
}

{ #category : #'api - instantiation' }
GtMagritteListElementStencilBuilder >> buildDefault [

	<return: #BlElement>
	| aFlowElement |
	(self memento isNil or: [ self description isNil ]) ifTrue: [ 
		^ BrFrame new fitContent ].

	aFlowElement := GtMagritteBuilderUtility
		                newFlowListMemento: self memento
		                using: self description.

	self form ifNotNil: [ :aForm | aForm matchParent ].

	^ GtMagritteValidatedFieldElement new
		  memento: self memento
		  description: self description
		  element: aFlowElement;
		  matchParent
]

{ #category : #accessing }
GtMagritteListElementStencilBuilder >> description [

	^ description
]

{ #category : #accessing }
GtMagritteListElementStencilBuilder >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteListElementStencilBuilder >> form [

	^ form
]

{ #category : #accessing }
GtMagritteListElementStencilBuilder >> form: anObject [

	form := anObject
]

{ #category : #accessing }
GtMagritteListElementStencilBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteListElementStencilBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - instantiation' }
GtMagritteListElementStencilBuilder >> paramsOn: aStencilExecutor [

	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self memento;
		push: self description;
		push: self form
]
