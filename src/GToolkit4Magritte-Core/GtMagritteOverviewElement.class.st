Class {
	#name : #GtMagritteOverviewElement,
	#superclass : #BrFrame,
	#instVars : [
		'memento',
		'overviews',
		'changedStatus',
		'validStatus',
		'activityStatus'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #initialization }
GtMagritteOverviewElement >> initialize [
	super initialize.
	overviews := BrHorizontalGrid new
			columnCount: 2;
			fitContent.

	changedStatus := self newLabelObserving: #isChanged.
	validStatus := self newLabelObserving: #isValid.
	activityStatus := self
			newLabelObserving: [ :aStatus | aStatus executionStatus label ].

	overviews
		addChild: ((self newLabel: 'Overall status')
				aptitudeDo: [ :anAptitude | 
					anAptitude
						foreground: BrGlamorousColors defaultHeaderTextColor;
						fontSize: 18;
						bold ];
				constraintsDo: [ :c | c grid horizontal span: 2 ]).

	overviews addChild: (self newLabel: 'Is value changed:').
	overviews addChild: changedStatus as: #isValueChanged.

	overviews addChild: (self newLabel: 'Is value valid:').
	overviews addChild: validStatus as: #isValueValid.

	overviews addChild: (self newLabel: 'Activity status:').
	overviews addChild: activityStatus as: #executionState.

	self addChild: overviews.

	self fitContent
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

{ #category : #'private - hooks' }
GtMagritteOverviewElement >> onMementoChanged [

	self updateOverviews
]

{ #category : #'private - updating' }
GtMagritteOverviewElement >> updateOverviews [
	self memento overallStatus observe: changedStatus asyncSink.
	self memento overallStatus observe: validStatus asyncSink.
	self memento overallStatus observe: activityStatus asyncSink
]
