Class {
	#name : #GtMagritteActionIconStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'description',
		'memento'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - instantiation' }
GtMagritteActionIconStencilBuilder >> buildDefault [
	<return: #BlElement>
	^ BrGlamorousVectorIcons inspect
]

{ #category : #accessing }
GtMagritteActionIconStencilBuilder >> description [

	^ description
]

{ #category : #accessing }
GtMagritteActionIconStencilBuilder >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteActionIconStencilBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteActionIconStencilBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - instantiation' }
GtMagritteActionIconStencilBuilder >> paramsOn: aStencilExecutor [

	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self memento;
		push: self description
]

{ #category : #initialization }
GtMagritteActionIconStencilBuilder >> reset [
	memento := nil.
	description := nil
]
