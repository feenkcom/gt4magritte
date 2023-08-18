Class {
	#name : #GtMagritteMementoViewModel,
	#superclass : #Object,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit4Magritte-Core-View Models'
}

{ #category : #accessing }
GtMagritteMementoViewModel >> memento [
	^ memento
]

{ #category : #accessing }
GtMagritteMementoViewModel >> memento: anObject [
	memento := anObject
]
