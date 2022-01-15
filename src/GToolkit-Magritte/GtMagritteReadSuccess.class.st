Class {
	#name : #GtMagritteReadSuccess,
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
GtMagritteReadSuccess >> isChanged [

	^ self original ~= self value
]

{ #category : #testing }
GtMagritteReadSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteReadSuccess >> original [

	^ original
]

{ #category : #accessing }
GtMagritteReadSuccess >> original: anObject [

	original := anObject
]

{ #category : #printing }
GtMagritteReadSuccess >> printOn: aStream [

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
GtMagritteReadSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteReadSuccess >> value: anObject [

	value := anObject
]
