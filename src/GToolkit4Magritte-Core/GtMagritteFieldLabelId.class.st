Class {
	#name : #GtMagritteFieldLabelId,
	#superclass : #BlElementId,
	#instVars : [
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #comparing }
GtMagritteFieldLabelId >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self description = anObject description
]

{ #category : #accessing }
GtMagritteFieldLabelId >> asSymbol [
	^ #'gt-magritte--field-label-', description label asSymbol
]

{ #category : #accessing }
GtMagritteFieldLabelId >> description [
	^ description
]

{ #category : #accessing }
GtMagritteFieldLabelId >> description: anObject [
	description := anObject
]

{ #category : #comparing }
GtMagritteFieldLabelId >> hash [
	^ self description hash
]
