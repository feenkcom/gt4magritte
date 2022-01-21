Class {
	#name : #GtMagritteValidationSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'context'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
}

{ #category : #accessing }
GtMagritteValidationSuccess >> context [

	^ context
]

{ #category : #accessing }
GtMagritteValidationSuccess >> context: anObject [

	context := anObject
]

{ #category : #testing }
GtMagritteValidationSuccess >> isSuccess [

	^ true
]
