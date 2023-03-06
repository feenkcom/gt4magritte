Class {
	#name : #GtMagritteValidatorElementId,
	#superclass : #BlElementId,
	#instVars : [
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #comparing }
GtMagritteValidatorElementId >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self description = anObject description
]

{ #category : #accessing }
GtMagritteValidatorElementId >> asSymbol [
	^ #'gt-magritte--validator-', description label asSymbol
]

{ #category : #accessing }
GtMagritteValidatorElementId >> description [
	^ description
]

{ #category : #accessing }
GtMagritteValidatorElementId >> description: anObject [
	description := anObject
]

{ #category : #comparing }
GtMagritteValidatorElementId >> hash [
	^ self description hash
]
