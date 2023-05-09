Class {
	#name : #GtMagritteFieldViewModel,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description'
	],
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #accessing }
GtMagritteFieldViewModel >> description [
	^ description
]

{ #category : #accessing }
GtMagritteFieldViewModel >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtMagritteFieldViewModel >> memento [
	^ memento
]

{ #category : #accessing }
GtMagritteFieldViewModel >> memento: anObject [
	memento := anObject
]
