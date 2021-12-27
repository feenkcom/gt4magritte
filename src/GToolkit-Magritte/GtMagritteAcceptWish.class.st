Class {
	#name : #GtMagritteAcceptWish,
	#superclass : #BrWish,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit-Magritte-Events'
}

{ #category : #accessing }
GtMagritteAcceptWish >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteAcceptWish >> memento: anObject [

	memento := anObject
]
