Class {
	#name : #GtMagritteWriteSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value',
		'context'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteWriteSuccess >> context [

	^ context
]

{ #category : #accessing }
GtMagritteWriteSuccess >> context: anObject [

	context := anObject
]

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
