Class {
	#name : #GtMagritteWriteSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value',
		'context',
		'original'
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
GtMagritteWriteSuccess >> isChanged [

	^ self original ~= self value
]

{ #category : #testing }
GtMagritteWriteSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteWriteSuccess >> original [

	^ original
]

{ #category : #accessing }
GtMagritteWriteSuccess >> original: anObject [

	original := anObject
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value: anObject [

	value := anObject
]
