Class {
	#name : #GtMagritteWriteSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'value',
		'context',
		'original',
		'validation'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
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

{ #category : #testing }
GtMagritteWriteSuccess >> isValidated [

	^ self validation isNotNil
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
GtMagritteWriteSuccess >> validation [

	^ validation
]

{ #category : #accessing }
GtMagritteWriteSuccess >> validation: anObject [

	validation := anObject
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value [

	^ value
]

{ #category : #accessing }
GtMagritteWriteSuccess >> value: anObject [

	value := anObject
]
