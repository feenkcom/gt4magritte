Class {
	#name : #GtMagritteExecutionExceptionStatus,
	#superclass : #GtMagritteExecutionStatus,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteExecutionExceptionStatus >> exception [
	^ exception
]

{ #category : #accessing }
GtMagritteExecutionExceptionStatus >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
GtMagritteExecutionExceptionStatus >> label [
	^ 'error'
]

{ #category : #accessing }
GtMagritteExecutionExceptionStatus >> messageText [
	^ self exception
		ifNotNil: [ :anException | anException messageText 
			ifEmpty: [ anException printString ] ]
		ifNil: [ 'Unknown error' ]
]

{ #category : #'api - ui' }
GtMagritteExecutionExceptionStatus >> updateToolbarExecutionStatus: aLabel [
	super updateToolbarExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility visible;
		aptitudeDo: [ :anAptitude | anAptitude foreground: BrGlamorousColors errorBackgroundColor ];
		text: self messageText
]
