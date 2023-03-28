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
GtMagritteExecutionExecutingStatus >> updateToolbarExecutionStatus: aLabel [
	super updateToolbarExecutionStatus: aLabel.
	aLabel
		visibility: BlVisibility visible;
		aptitudeDo: [ :anAptitude | anAptitude foreground: BrGlamorousColors disabledButtonTextColor ];
		text: 'Executing...'
]
