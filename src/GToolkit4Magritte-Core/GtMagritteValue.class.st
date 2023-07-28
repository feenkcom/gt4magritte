Class {
	#name : #GtMagritteValue,
	#superclass : #Object,
	#instVars : [
		'description',
		'currentValue',
		'originalValue',
		'validation'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #copying }
GtMagritteValue >> copyWithCurrentValue: anObject [

	^ self copy
		  currentValue: anObject;
		  validation: nil
]

{ #category : #copying }
GtMagritteValue >> copyWithOriginalValue: anObject [

	| aCopy |
	aCopy := self copy.

	aCopy isChanged
		ifTrue: [ 
			aCopy originalValue: anObject ]
		ifFalse: [ 
			aCopy
				currentValue: anObject;
				originalValue: anObject;
				validation: nil ].

	^ aCopy
]

{ #category : #accessing }
GtMagritteValue >> currentValue [

	^ currentValue
]

{ #category : #accessing }
GtMagritteValue >> currentValue: anObject [

	currentValue := anObject
]

{ #category : #accessing }
GtMagritteValue >> description [

	^ description
]

{ #category : #accessing }
GtMagritteValue >> description: anObject [

	description := anObject
]

{ #category : #'gt - extensions' }
GtMagritteValue >> gtDescriptionFor: aView [
	<gtView>
	self description ifNil: [ ^ aView empty ].
	self description definingSource ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Description';
		priority: 49;
		object: [ self description ];
		view: #gtMagritteFor:
]

{ #category : #'gt - extensions' }
GtMagritteValue >> gtSourceFor: aView [
	<gtView>
	self description ifNil: [ ^ aView empty ].
	self description definingSource ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Source';
		priority: 20;
		object: [ self description ];
		view: #gtSourceFor:
]

{ #category : #testing }
GtMagritteValue >> isChanged [

	^ self currentValue ~= self originalValue
]

{ #category : #testing }
GtMagritteValue >> isValid [

	^ self validation isSuccess
]

{ #category : #testing }
GtMagritteValue >> isValidated [

	^ self validation isNotNil
]

{ #category : #accessing }
GtMagritteValue >> issuesDescription [

	^ self validation issuesDescription
]

{ #category : #accessing }
GtMagritteValue >> originalValue [

	^ originalValue
]

{ #category : #accessing }
GtMagritteValue >> originalValue: anObject [

	originalValue := anObject
]

{ #category : #accessing }
GtMagritteValue >> printOn: aStream [
	super printOn: aStream.

	self description ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		nextPutAll: self description label asString;
		nextPutAll: '=';
		nextPutAll: self currentValue asString;
		nextPut: $)
]

{ #category : #accessing }
GtMagritteValue >> validation [

	^ validation
]

{ #category : #accessing }
GtMagritteValue >> validation: anObject [

	validation := anObject
]
