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
GtMagritteExecutionExceptionStatus >> updateToolbarExceptionExecutionStatus: anExceptionContainer [
	super updateToolbarExceptionExecutionStatus: anExceptionContainer.
	anExceptionContainer
		visibility: BlVisibility visible;
		removeChildren;
		addChild: (GtMagritteBuilderUtility debugButtonForException: self exception)
]

{ #category : #'api - ui' }
GtMagritteExecutionExceptionStatus >> updateToolbarLabelExecutionStatus: aLabel [
	super updateToolbarLabelExecutionStatus: aLabel.
	GtMagritteBuilderUtility
		updateToolbarLabelExecutionStatus: aLabel
		withExceptionText: self messageText.
]
