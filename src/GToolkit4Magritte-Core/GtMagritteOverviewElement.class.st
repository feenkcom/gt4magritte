Class {
	#name : #GtMagritteOverviewElement,
	#superclass : #BrFrame,
	#instVars : [
		'memento',
		'overviews',
		'changedStatus',
		'validStatus',
		'activityStatus',
		'executionStatus'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #initialization }
GtMagritteOverviewElement >> initialize [
	super initialize.
	overviews := BrHorizontalGrid new
			columnCount: 2;
			fitContent;
			alignCenter.
			
	self initializeOverallStatus.
	self initializeExecutionStatus.

	self addChild: overviews.

	self fitContent
]

{ #category : #initialization }
GtMagritteOverviewElement >> initializeExecutionStatus [
	| statusContainer |
	executionStatus := self newLabelObserving: #label.
	statusContainer := self
			newContainerWithStatus: executionStatus
			spawning: [ :aMemento | aMemento executionStatus valueOrNil ].


	overviews
		addChild: ((self newTitle: 'Execution status')
				in: [ :aLabel | aLabel margin: (BlInsets top: 10) + aLabel margin ];
				yourself).

	overviews addChild: (self newLabel: 'Activity status:').
	overviews addChild: statusContainer as: #executionStatus
]

{ #category : #initialization }
GtMagritteOverviewElement >> initializeOverallStatus [
	| statusContainer |
	changedStatus := self newLabelObserving: #isChanged.
	validStatus := self newLabelObserving: #isValid.
	activityStatus := self
			newLabelObserving: [ :aStatus | aStatus executionStatus label ].
			
	statusContainer := self
			newContainerWithStatus: activityStatus
			spawning: [ :aMemento | aMemento executionStatus valueOrNil ].


	overviews addChild: (self newTitle: 'Overall status').

	overviews addChild: (self newLabel: 'Is value changed:').
	overviews addChild: changedStatus as: #isValueChanged.

	overviews addChild: (self newLabel: 'Is value valid:').
	overviews addChild: validStatus as: #isValueValid.

	overviews addChild: (self newLabel: 'Activity status:').
	overviews addChild: statusContainer as: #activityStatus
]

{ #category : #accessing }
GtMagritteOverviewElement >> memento [
	^ memento
]

{ #category : #accessing }
GtMagritteOverviewElement >> memento: aMemento [
	memento := aMemento.
	
	self onMementoChanged
]

{ #category : #initialization }
GtMagritteOverviewElement >> newContainerWithStatus: anElement spawning: aSpawnBlock [
	| aContainer aButton |
	aContainer := BrHorizontalPane new fitContent.

	anElement constraintsDo: [ :c | c linear vertical alignCenter ].

	aButton := BrButton new
			fitContent;
			beMiniSize;
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons inspect;
			label: 'Inspect';
			constraintsDo: [ :c | c linear vertical alignCenter ];
			margin: (BlInsets left: 5);
			action: [ :theButton | 
				self memento
					ifNotNil: [ :aMemento | 
						(aSpawnBlock cull: aMemento)
							ifNotNil: [ :anObject | theButton phlow spawnObject: anObject ] ] ].

	aContainer
		addChild: anElement;
		addChild: aButton.
	^ aContainer
]

{ #category : #initialization }
GtMagritteOverviewElement >> newLabel: aString [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				foreground: BrGlamorousColors disabledButtonTextColor);
		text: aString;
		margin: (BlInsets
				top: 0
				right: 10
				bottom: 10
				left: 0)
]

{ #category : #initialization }
GtMagritteOverviewElement >> newLabelObserving: aSelector [
	^ BrLabel new
		text: '?';
		aptitude: BrGlamorousLabelAptitude;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theLabel :aSink | 
					| aValue |
					aValue := aSink value.

					theLabel text: (aValue ifNotNil: aSelector ifNil: [ '?' ]) asString ] ]
]

{ #category : #initialization }
GtMagritteOverviewElement >> newTitle: aString [
	^ (self newLabel: aString)
		aptitudeDo: [ :anAptitude | 
			anAptitude
				foreground: BrGlamorousColors defaultHeaderTextColor;
				fontSize: 18;
				bold ];
		constraintsDo: [ :c | c grid horizontal span: 2 ]
]

{ #category : #'private - hooks' }
GtMagritteOverviewElement >> onMementoChanged [

	self updateOverviews
]

{ #category : #'private - updating' }
GtMagritteOverviewElement >> updateOverviews [
	self memento overallStatus observe: changedStatus asyncSink.
	self memento overallStatus observe: validStatus asyncSink.
	self memento overallStatus observe: activityStatus asyncSink.
	self memento executionStatus observe: executionStatus asyncSink
]
