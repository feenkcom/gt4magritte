Class {
	#name : #GtMagritteAsyncValidationSuccess,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteAsyncValidationSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteAsyncValidationSuccess >> value [

	<return: #GtMagritteValue>
	^ value
]

{ #category : #accessing }
GtMagritteAsyncValidationSuccess >> value: anObject [

	value := anObject
]
