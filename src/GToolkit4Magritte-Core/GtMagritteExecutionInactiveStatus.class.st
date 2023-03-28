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
GtMagritteExecutionInactiveStatus >> updateToolbarExecutionStatus: aLabel [
	super updateToolbarExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility gone;
		text: ''
]
