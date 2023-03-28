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
GtMagritteExecutionAboutToStartStatus >> updateToolbarExecutionStatus: aLabel [
	super updateToolbarExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility visible;
		aptitudeDo: [ :anAptitude | anAptitude foreground: BrGlamorousColors disabledButtonTextColor ];
		text: 'Scheduling...'
]