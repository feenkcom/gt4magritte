Class {
	#name : #GtMagritteDescriptionElementStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'description',
		'memento'
	],
	#category : #'GToolkit4Magritte-Core-Widgets Stencil Builders'
}

{ #category : #testing }
GtMagritteDescriptionElementStencilBuilder class >> isAbstract [
	^ self name = #GtMagritteDescriptionElementStencilBuilder
]

{ #category : #'api - instantiation' }
GtMagritteDescriptionElementStencilBuilder >> buildDefault [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #accessing }
GtMagritteDescriptionElementStencilBuilder >> description [
	<return: #MADescription>
	^ description
]

{ #category : #accessing }
GtMagritteDescriptionElementStencilBuilder >> description: aDescription [
	description := aDescription
]

{ #category : #accessing }
GtMagritteDescriptionElementStencilBuilder >> memento [
	<return: #GtMagritteMemento>
	^ memento
]

{ #category : #accessing }
GtMagritteDescriptionElementStencilBuilder >> memento: aMemento [
	memento := aMemento
]

{ #category : #'api - instantiation' }
GtMagritteDescriptionElementStencilBuilder >> paramsOn: aStencilExecutor [
	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self memento;
		push: self description
]

{ #category : #initialization }
GtMagritteDescriptionElementStencilBuilder >> reset [
	description := nil.
	memento := nil
]
