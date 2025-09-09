Class {
	#name : #GtMagritteFormStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - instantiation' }
GtMagritteFormStencilBuilder >> buildDefault [
	<return: #BrStencil or: #BlElement>
	^ GtMagritteBuilderUtility newHorizontalGridContainer
]

{ #category : #accessing }
GtMagritteFormStencilBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteFormStencilBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - instantiation' }
GtMagritteFormStencilBuilder >> paramsOn: aStencilExecutor [

	super paramsOn: aStencilExecutor.
	aStencilExecutor push: self memento
]

{ #category : #accessing }
GtMagritteFormStencilBuilder >> reset [
	memento := nil
]
