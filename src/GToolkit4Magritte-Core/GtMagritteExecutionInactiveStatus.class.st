Class {
	#name : #GtMagritteExecutionInactiveStatus,
	#superclass : #GtMagritteExecutionStatus,
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteExecutionInactiveStatus >> label [
	^ 'inactive'
]

{ #category : #'api - ui' }
GtMagritteExecutionInactiveStatus >> updateToolbarExceptionExecutionStatus: anExceptionContainer [
	super updateToolbarExceptionExecutionStatus: anExceptionContainer.
	anExceptionContainer
		visibility: BlVisibility gone;
		removeChildren
]

{ #category : #'api - ui' }
GtMagritteExecutionInactiveStatus >> updateToolbarLabelExecutionStatus: aLabel [
	super updateToolbarLabelExecutionStatus: aLabel.
	GtMagritteBuilderUtility 
		updateToolbarLabelExecutionStatus: aLabel 
		withText: ''.
	aLabel visibility: BlVisibility gone
]
