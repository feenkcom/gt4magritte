Class {
	#name : #GtMagritteExecutionExecutingStatus,
	#superclass : #GtMagritteExecutionStatus,
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #testing }
GtMagritteExecutionExecutingStatus >> isActive [
	^ true
]

{ #category : #testing }
GtMagritteExecutionExecutingStatus >> isExecuting [
	^ true
]

{ #category : #accessing }
GtMagritteExecutionExecutingStatus >> label [
	^ 'executing'
]

{ #category : #'api - ui' }
GtMagritteExecutionExecutingStatus >> updateToolbarExceptionExecutionStatus: anExceptionContainer [
	super updateToolbarExceptionExecutionStatus: anExceptionContainer.
	anExceptionContainer
		visibility: BlVisibility gone;
		removeChildren
]

{ #category : #'api - ui' }
GtMagritteExecutionExecutingStatus >> updateToolbarLabelExecutionStatus: aLabel [
	super updateToolbarLabelExecutionStatus: aLabel.
	GtMagritteBuilderUtility
		updateToolbarLabelExecutionStatus: aLabel
		withText: 'Executing...'
]
