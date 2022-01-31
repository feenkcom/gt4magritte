Class {
	#name : #GtMagritteDefiningMethod,
	#superclass : #Object,
	#instVars : [
		'method'
	],
	#category : #'GToolkit-Magritte-Core-Models'
}

{ #category : #'instance creation' }
GtMagritteDefiningMethod class >> fromStack: aStack [

	<return: #GtMagritteDefiningMethod or: nil>
	| aCompiledMethod |
	aStack size > 1 ifFalse: [ ^ nil ].

	aCompiledMethod := (aStack at: 2) blocDefiningMethod.

	^ self new method: aCompiledMethod asRingDefinition
]

{ #category : #accessing }
GtMagritteDefiningMethod >> method [

	^ method
]

{ #category : #accessing }
GtMagritteDefiningMethod >> method: anObject [

	method := anObject
]
