Class {
	#name : #GtMagritteExecutionStatus,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #'api - factory' }
GtMagritteExecutionStatus class >> aboutToStart [
	^ GtMagritteExecutionAboutToStartStatus new
]

{ #category : #'api - factory' }
GtMagritteExecutionStatus class >> callbackExceptions: aCollection [
	^ GtMagritteExecutionCallbackExceptionStatus new exceptions: aCollection
]

{ #category : #'api - factory' }
GtMagritteExecutionStatus class >> exception: anException [
	^ GtMagritteExecutionExceptionStatus new exception: anException
]

{ #category : #'api - factory' }
GtMagritteExecutionStatus class >> executing [
	^ GtMagritteExecutionExecutingStatus new
]

{ #category : #'api - factory' }
GtMagritteExecutionStatus class >> inactive [
	^ GtMagritteExecutionInactiveStatus new
]

{ #category : #comparing }
GtMagritteExecutionStatus >> = anObject [

	self == anObject ifTrue: [ ^ true ].

	self species = anObject species ifFalse: [ ^ false ].
	
	^ true
]

{ #category : #comparing }
GtMagritteExecutionStatus >> hash [
	^ self species hash
]

{ #category : #testing }
GtMagritteExecutionStatus >> isActive [
	^ false
]

{ #category : #testing }
GtMagritteExecutionStatus >> isExecuting [
	^ false
]

{ #category : #accessing }
GtMagritteExecutionStatus >> label [
	^ self printString
]

{ #category : #'api - ui' }
GtMagritteExecutionStatus >> updateToolbarExecutionStatus: aLabel [
	
]
