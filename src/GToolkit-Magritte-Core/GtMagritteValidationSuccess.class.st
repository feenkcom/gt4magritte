Class {
	#name : #GtMagritteValidationSuccess,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'GToolkit-Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteValidationSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteValidationSuccess >> value [

	<return: #GtMagritteValue>
	^ value
]

{ #category : #accessing }
GtMagritteValidationSuccess >> value: anObject [

	value := anObject
]
