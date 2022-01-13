Class {
	#name : #GtMagritteDescriptionValidationSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteDescriptionValidationSuccess >> description [

	^ description
]

{ #category : #accessing }
GtMagritteDescriptionValidationSuccess >> description: anObject [

	description := anObject
]

{ #category : #testing }
GtMagritteDescriptionValidationSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteDescriptionValidationSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteDescriptionValidationSuccess >> value: anObject [

	value := anObject
]
