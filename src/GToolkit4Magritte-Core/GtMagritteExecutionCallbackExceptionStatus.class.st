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
				ifTrue: [ aCollection anyOne messageText printStringLimitedTo: 18 ]
				ifFalse: [ aCollection size asString , ' callbacks failed' ] ]
		ifNil: [ 'Unknown error' ]
]

{ #category : #'api - ui' }
GtMagritteExecutionCallbackExceptionStatus >> updateToolbarExceptionExecutionStatus: anExceptionContainer [
	| aDebugButton |
	super updateToolbarExceptionExecutionStatus: anExceptionContainer.

	aDebugButton := GtMagritteBuilderUtility
			debugButtonForException: self exceptions anyOne exception.

	self exceptions size = 1
		ifFalse: [ aDebugButton action: [ :aButton | self exceptions inspect ] ].

	anExceptionContainer
		visibility: BlVisibility visible;
		removeChildren;
		addChild: aDebugButton
]

{ #category : #'api - ui' }
GtMagritteExecutionCallbackExceptionStatus >> updateToolbarLabelExecutionStatus: aLabel [
	super updateToolbarLabelExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility visible;
		aptitudeDo: [ :anAptitude | anAptitude foreground: BrGlamorousColors errorBackgroundColor ];
		text: self messageText
]
