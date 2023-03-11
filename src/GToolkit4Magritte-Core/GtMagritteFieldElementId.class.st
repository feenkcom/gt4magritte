Class {
	#name : #GtMagritteFieldElementId,
	#superclass : #BlElementId,
	#instVars : [
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #comparing }
GtMagritteFieldElementId >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self asSymbol = anObject asSymbol
]

{ #category : #accessing }
GtMagritteFieldElementId >> asSymbol [
	^ #'gt-magritte--field-', description label asSymbol
]

{ #category : #accessing }
GtMagritteFieldElementId >> description [
	^ description
]

{ #category : #accessing }
GtMagritteFieldElementId >> description: anObject [
	description := anObject
]

{ #category : #comparing }
GtMagritteFieldElementId >> hash [
	^ self description hash
]
