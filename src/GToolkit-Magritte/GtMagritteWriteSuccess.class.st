Class {
	#name : #GtMagritteWriteSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteWriteSuccess >> description [

	^ description
]

{ #category : #accessing }
GtMagritteWriteSuccess >> description: anObject [

	description := anObject
]

{ #category : #testing }
GtMagritteWriteSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value: anObject [

	value := anObject
]
