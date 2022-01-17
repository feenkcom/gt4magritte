Class {
	#name : #GtMagritteNewViewModel,
	#superclass : #Object,
	#instVars : [
		'memento',
		'builder'
	],
	#category : #'GToolkit-Magritte-View Models'
}

{ #category : #'api - building' }
GtMagritteNewViewModel >> asElement [

	| aBuilder |
	aBuilder := self builder.

	aBuilder memento: self memento.

	^ aBuilder asElement
]

{ #category : #converting }
GtMagritteNewViewModel >> asGtMagritteNewViewModel [

	^ self
]

{ #category : #accessing }
GtMagritteNewViewModel >> builder [

	^ builder ifNil: [ builder := self createBuilder ]
]

{ #category : #accessing }
GtMagritteNewViewModel >> builder: anObject [

	builder := anObject
]

{ #category : #'private - building' }
GtMagritteNewViewModel >> createBuilder [

	^ GtMagritteNewEditableElementBuilder new addButtons
]

{ #category : #accessing }
GtMagritteNewViewModel >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteNewViewModel >> memento: anObject [

	memento := anObject
]
