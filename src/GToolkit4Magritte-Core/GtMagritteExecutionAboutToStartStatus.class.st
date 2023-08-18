Class {
	#name : #GtMagritteExecutionAboutToStartStatus,
	#superclass : #GtMagritteExecutionStatus,
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #testing }
GtMagritteExecutionAboutToStartStatus >> isActive [
	^ true
]

{ #category : #accessing }
GtMagritteExecutionAboutToStartStatus >> label [
	^ 'starting'
]

{ #category : #accessing }
GtMagritteExecutionAboutToStartStatus >> updateToolbarExceptionExecutionStatus: anExceptionContainer [
	super updateToolbarExceptionExecutionStatus: anExceptionContainer.
	anExceptionContainer
		visibility: BlVisibility gone;
		removeChildren
]

{ #category : #accessing }
GtMagritteExecutionAboutToStartStatus >> updateToolbarLabelExecutionStatus: aLabel [
	super updateToolbarLabelExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility visible;
		aptitudeDo: [ :anAptitude | anAptitude foreground: BrGlamorousColors disabledButtonTextColor ];
		text: 'Scheduling...'
]
