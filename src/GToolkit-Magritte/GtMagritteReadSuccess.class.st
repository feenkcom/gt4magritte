Class {
	#name : #GtMagritteReadSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value',
		'context'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteReadSuccess >> context [

	^ context
]

{ #category : #accessing }
GtMagritteReadSuccess >> context: anObject [

	context := anObject
]

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
