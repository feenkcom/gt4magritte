Class {
	#name : #GtMagritteExecutionCallbackExceptionStatus,
	#superclass : #GtMagritteExecutionStatus,
	#instVars : [
		'exceptions'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteExecutionCallbackExceptionStatus >> exceptions [
	^ exceptions
]

{ #category : #accessing }
GtMagritteExecutionCallbackExceptionStatus >> exceptions: anObject [
	exceptions := anObject
]

{ #category : #accessing }
GtMagritteExecutionCallbackExceptionStatus >> label [
	^ 'callback error'
]

{ #category : #accessing }
GtMagritteExecutionCallbackExceptionStatus >> messageText [
	^ self exceptions
		ifNotNil: [ :aCollection | 
			aCollection size = 1
				ifTrue: [ aCollection anyOne messageText ]
				ifFalse: [ aCollection size asString , ' callbacks failed' ] ]
		ifNil: [ 'Unknown error' ]
]

{ #category : #'api - ui' }
GtMagritteExecutionCallbackExceptionStatus >> updateToolbarExecutionStatus: aLabel [
	super updateToolbarExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility visible;
		aptitudeDo: [ :anAptitude | anAptitude foreground: BrGlamorousColors errorBackgroundColor ];
		text: self messageText
]
