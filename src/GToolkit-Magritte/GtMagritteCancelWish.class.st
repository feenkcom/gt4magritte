Class {
	#name : #GtMagritteCancelWish,
	#superclass : #BrWish,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit-Magritte-Events'
}

{ #category : #accessing }
GtMagritteCancelWish >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteCancelWish >> memento: anObject [

	memento := anObject
]
