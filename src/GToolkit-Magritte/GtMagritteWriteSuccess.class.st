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

{ #category : #printing }
GtMagritteWriteSuccess >> printOn: aStream [

	super printOn: aStream.

	self description ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self description label asString;
		nextPut: $=;
		print: self value;
		nextPut: $)
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value: anObject [

	value := anObject
]
