"
I represent a progress widget that does not know how the progress percentage.
# Example
{{gtExample:GtMagritteProgressElement class>>#itself|noCode | previewShow=#gtLiveFor: | previewHeight=120}}
"
Class {
	#name : #GtMagritteProgressElement,
	#superclass : #BrFrame,
	#instVars : [
		'primaryTickIndex',
		'tickBackgroundColor'
	],
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #accessing }
GtMagritteProgressElement class >> gray [
	^ self new gray
]

{ #category : #accessing }
GtMagritteProgressElement class >> green [
	^ self new green
]

{ #category : #accessing }
GtMagritteProgressElement class >> itself [
	<gtExample>
	^ self new
]

{ #category : #accessing }
GtMagritteProgressElement class >> red [
	^ self new red
]

{ #category : #accessing }
GtMagritteProgressElement class >> yellow [
	^ self new yellow
]

{ #category : #initialization }
GtMagritteProgressElement >> defaultTickBackgroundColor [
	^ BrGlamorousColors defaultShadowColor
]

{ #category : #initialization }
GtMagritteProgressElement >> defaultTickBreadth [
	^ 0.1
]

{ #category : #initialization }
GtMagritteProgressElement >> defaultTickLength [
	^ 0.48
]

{ #category : #'api - color' }
GtMagritteProgressElement >> gray [
	self tickBackgroundColor: BrGlamorousColors lightBorderColor
]

{ #category : #'api - color' }
GtMagritteProgressElement >> green [
	self tickBackgroundColor: BrGlamorousColors successBackgroundColor
]

{ #category : #initialization }
GtMagritteProgressElement >> initialize [
	super initialize.

	primaryTickIndex := 1.

	self initializeTicks.
	self initializeAnimation.
	self matchParent
]

{ #category : #initialization }
GtMagritteProgressElement >> initializeAnimation [
	self
		enqueueTask: (BlRepeatedTaskAction new
				delay: 1 seconds;
				action: [ self updateTicks ])
]

{ #category : #initialization }
GtMagritteProgressElement >> initializeTicks [
	self
		addChild: (self newTick
				visibility: BlVisibility visible;
				constraintsDo: [ :c | 
					c frame vertical alignCenter.
					c frame horizontal alignRight ]).
	self
		addChild: (self newTick
				visibility: BlVisibility hidden;
				constraintsDo: [ :c | 
					c frame vertical alignCenter.
					c frame horizontal alignLeft ])
]

{ #category : #initialization }
GtMagritteProgressElement >> newTick [
	^ BlElement new
		background: self defaultTickBackgroundColor;
		geometry: BlCircleGeometry new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent.
			c frame horizontal weight: 0.5.
			c frame vertical weight: 0.5 ]
]

{ #category : #'api - color' }
GtMagritteProgressElement >> red [
	self tickBackgroundColor: BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
GtMagritteProgressElement >> tickBackgroundColor: aColor [
	self childrenDo: [ :aChild | aChild background: aColor ]
]

{ #category : #'private - updating' }
GtMagritteProgressElement >> updateTicks [
	| anIndex |
	NonInteractiveTranscript stdout show: 'tick '.

	primaryTickIndex := primaryTickIndex + 1.
	primaryTickIndex > 2 ifTrue: [ primaryTickIndex := 1 ].

	anIndex := primaryTickIndex.
	(self childAt: anIndex) visibility: BlVisibility visible.

	anIndex := anIndex + 1.
	anIndex > 2 ifTrue: [ anIndex := 1 ].
	(self childAt: anIndex) visibility: BlVisibility hidden
]

{ #category : #'api - color' }
GtMagritteProgressElement >> yellow [
	self tickBackgroundColor: BrGlamorousColors failureBackgroundColor
]
