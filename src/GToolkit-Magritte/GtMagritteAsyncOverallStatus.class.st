Class {
	#name : #GtMagritteAsyncOverallStatus,
	#superclass : #Object,
	#instVars : [
		'isChanged',
		'isValid'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteAsyncOverallStatus >> isChanged [

	^ isChanged
]

{ #category : #accessing }
GtMagritteAsyncOverallStatus >> isChanged: anObject [

	isChanged := anObject
]

{ #category : #accessing }
GtMagritteAsyncOverallStatus >> isChangedAndValid [

	^ self isChanged and: [ self isValid ]
]

{ #category : #accessing }
GtMagritteAsyncOverallStatus >> isValid [

	^ isValid
]

{ #category : #accessing }
GtMagritteAsyncOverallStatus >> isValid: anObject [

	isValid := anObject
]

{ #category : #printing }
GtMagritteAsyncOverallStatus >> printOn: aStream [

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
