"
I represent a {{gtClass: MAElementDescription}} value in a {{gtClass: GtMagritteMemento}} object. 
I am an **immutable object**. Users should create new instances if a new value should be propagated in the Magritte model. See provided methods:
- {{gtMethod: GtMagritteValue >> #copyWithOriginalValue: }}, and
- {{gtMethod: GtMagritteValue >> #copyWithCurrentValue:}}. 
"
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
	"Create a new instance of myself with a new original value.
	If am not changed, then I change both, current and original values."

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
	"Get a current value provided by a user (using a UI widget).
	Note that this value is usually not propagated immediatelly to a model 
	(users must click on a accept button)."

	^ currentValue
]

{ #category : #accessing }
GtMagritteValue >> currentValue: anObject [
	"Set a current value provided by a user (using a UI widget).
	Note that this value is usually not propagated immediatelly to a model 
	(users must click on a accept button)."

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
	self description definingContext ifNil: [ ^ aView empty ].

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
	"Get an original value provided by a model."

	^ originalValue
]

{ #category : #accessing }
GtMagritteValue >> originalValue: anObject [
	"Set an original value provided by a model."

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
	"Return validation result.
	Notice that the validation is not provided immediatelly (see #isValidated)."

	<return: #GtMagritteValidationSuccess or: #GtMagritteValidationFailure>
	^ validation
]

{ #category : #accessing }
GtMagritteValue >> validation: anObject [
	"Set current value validation result.
	Notice that the validation is not provided immediatelly (see #isValidated).
	
	See {{gtMethod: GtMagritteMemento >> #validateValue: }} for more details."

	validation := anObject
]
