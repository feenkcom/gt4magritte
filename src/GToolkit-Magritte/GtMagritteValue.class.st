Class {
	#name : #GtMagritteValue,
	#superclass : #Object,
	#instVars : [
		'description',
		'currentValue',
		'originalValue',
		'validation'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #copying }
GtMagritteValue >> copyWithCurrentValue: anObject [

	^ self copy
		  currentValue: anObject;
		  validation: nil
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
GtMagritteValue >> validation [

	^ validation
]

{ #category : #accessing }
GtMagritteValue >> validation: anObject [

	validation := anObject
]
