Class {
	#name : #GtMagritteDescriptionValidationSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'result'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
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
GtMagritteDescriptionValidationSuccess >> result [

	^ result
]

{ #category : #accessing }
GtMagritteDescriptionValidationSuccess >> result: anObject [

	result := anObject
]

{ #category : #accessing }
GtMagritteDescriptionValidationSuccess >> value [

	^ self result value
]
