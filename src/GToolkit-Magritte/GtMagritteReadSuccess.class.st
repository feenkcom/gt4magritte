Class {
	#name : #GtMagritteReadSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteReadSuccess >> description [

	^ description
]

{ #category : #accessing }
GtMagritteReadSuccess >> description: anObject [

	description := anObject
]

{ #category : #testing }
GtMagritteReadSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteReadSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteReadSuccess >> value: anObject [

	value := anObject
]
