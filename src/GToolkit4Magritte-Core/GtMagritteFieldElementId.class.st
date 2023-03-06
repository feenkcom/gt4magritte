Class {
	#name : #GtMagritteFieldElementId,
	#superclass : #BlElementId,
	#instVars : [
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #accessing }
GtMagritteFieldElementId >> asSymbol [
	^ #'gt-magritte--', description label asSymbol
]

{ #category : #accessing }
GtMagritteFieldElementId >> description [
	^ description
]

{ #category : #accessing }
GtMagritteFieldElementId >> description: anObject [
	description := anObject
]
