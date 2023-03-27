Class {
	#name : #GtMagritteOverallStatus,
	#superclass : #Object,
	#instVars : [
		'isChanged',
		'isValid',
		'executionStatus'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteOverallStatus >> executionStatus [
	<return: #GtMagritteExecutionStatus>
	^ executionStatus
]

{ #category : #accessing }
GtMagritteOverallStatus >> executionStatus: aGtMagritteExecutionStatus [
	executionStatus := aGtMagritteExecutionStatus
]

{ #category : #accessing }
GtMagritteOverallStatus >> isActive [
	^ self executionStatus isActive
]

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
GtMagritteOverallStatus >> isExecuting [
	^ self executionStatus isExecuting
]

{ #category : #accessing }
GtMagritteOverallStatus >> isInactive [
	^ self isActive not
]

{ #category : #accessing }
GtMagritteOverallStatus >> isValid [

	^ isValid
]

{ #category : #accessing }
GtMagritteOverallStatus >> isValid: anObject [

	isValid := anObject
]

{ #category : #accessing }
GtMagritteOverallStatus >> isValidAndInactive [
	^ self isValid and: [ self isInactive ]
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
		nextPutAll: ', executing=';
		print: (self executionStatus ifNotNil: #label);
		nextPut: $)
]
