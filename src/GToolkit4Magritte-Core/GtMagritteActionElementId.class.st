Class {
	#name : #GtMagritteActionElementId,
	#superclass : #BlElementId,
	#instVars : [
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #comparing }
GtMagritteActionElementId >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].

	self class = anObject class
		ifFalse: [ ^ false ].

	^ self asSymbol = anObject asSymbol
]

{ #category : #accessing }
GtMagritteActionElementId >> asSymbol [
	^ #'gt-magritte--action-', description label asSymbol
]

{ #category : #accessing }
GtMagritteActionElementId >> description [
	^ description
]

{ #category : #accessing }
GtMagritteActionElementId >> description: anObject [
	description := anObject
]

{ #category : #comparing }
GtMagritteActionElementId >> hash [
	^ self description hash
]
