Class {
	#name : #GtMagritteOverallStatus,
	#superclass : #Object,
	#instVars : [
		'isChanged',
		'isValid'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteOverallStatus >> isChanged [

	^ isChanged
]

{ #category : #accessing }
GtMagritteOverallStatus >> isChanged: anObject [

	isChanged := anObject
]

{ #category : #accessing }
GtMagritteOverallStatus >> isChangedAndValid [

	^ self isChanged and: [ self isValid ]
]

{ #category : #accessing }
GtMagritteOverallStatus >> isValid [

	^ isValid
]

{ #category : #accessing }
GtMagritteOverallStatus >> isValid: anObject [

	isValid := anObject
]

{ #category : #printing }
GtMagritteOverallStatus >> printOn: aStream [

	super printOn: aStream.

	self isChanged ifNil: [ ^ self ].
	self isValid ifNil: [ ^ self ].

	aStream
		nextPutAll: '(changed=';
		print: self isChanged;
		nextPutAll: ', valid=';
		print: self isValid;
		nextPut: $)
]
