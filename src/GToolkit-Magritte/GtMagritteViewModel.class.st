Class {
	#name : #GtMagritteViewModel,
	#superclass : #Object,
	#instVars : [
		'object',
		'builder',
		'memento',
		'objectDescription'
	],
	#category : #'GToolkit-Magritte-View Models'
}

{ #category : #converting }
GtMagritteViewModel >> asElement [

	| aBuilder |
	aBuilder := self builder.
	
	aBuilder object: self object.
	aBuilder objectDescription: self objectDescription.
	aBuilder memento: self memento.
	
	^ aBuilder asElement
]

{ #category : #converting }
GtMagritteViewModel >> asGtMagritteViewModel [

	^ self
]

{ #category : #accessing }
GtMagritteViewModel >> builder [

	^ builder ifNil: [ builder := self createBuilder ]
]

{ #category : #accessing }
GtMagritteViewModel >> builder: anObject [

	builder := anObject
]

{ #category : #'private - building' }
GtMagritteViewModel >> createBuilder [

	^ GtMagritteEditableElementBuilder new addButtons
]

{ #category : #'private - building' }
GtMagritteViewModel >> createMemento [

	^ self object mementoClass
		  model: self object
		  description: self objectDescription
]

{ #category : #'private - building' }
GtMagritteViewModel >> createObjectDescription [

	^ self object magritteDescription
]

{ #category : #accessing }
GtMagritteViewModel >> gtLiveFor: aView [

	<gtView>
	^ aView explicit
		  title: 'Live';
		  priority: 1;
		  stencil: [ self ]
]

{ #category : #accessing }
GtMagritteViewModel >> memento [

	^ memento ifNil: [ memento := self createMemento]
]

{ #category : #accessing }
GtMagritteViewModel >> memento: anObject [

	memento := anObject
]

{ #category : #accessing }
GtMagritteViewModel >> object [

	^ object
]

{ #category : #accessing }
GtMagritteViewModel >> object: anObject [

	object := anObject
]

{ #category : #accessing }
GtMagritteViewModel >> objectDescription [

	^ objectDescription ifNil: [ objectDescription := self createObjectDescription]
]

{ #category : #accessing }
GtMagritteViewModel >> objectDescription: anObject [

	objectDescription := anObject
]
