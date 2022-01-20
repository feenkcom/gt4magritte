Class {
	#name : #GtMagritteAsyncBuilderUtility,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-New-Builders'
}

{ #category : #'api - ui' }
GtMagritteAsyncBuilderUtility class >> defaultSpaceNumber [

	^ 4
]

{ #category : #'api - ui' }
GtMagritteAsyncBuilderUtility class >> defaultThickness [

	^ 3
]

{ #category : #'api - ui' }
GtMagritteAsyncBuilderUtility class >> newEditableLabelWithMemento: aMemento using: aDescription [

	| anEditor |
	anEditor := BrEditableLabel new.

	anEditor
		aptitude:
			BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		vFitContent;
		hFitContentLimited;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeakSink new;
				whenUpdate: [ :aLabel :aSink | 
					aLabel text: aSink value currentValue ].
			(aMemento readObservableValueUsing: aDescription) observe:
				anElementSink ];
		when: BrEditorAcceptWish do: [ :aWish | 
		aWish consumed: true.
		aMemento write: aWish text asString using: aDescription ];
		margin: (BlInsets bottom: self defaultSpaceNumber);
		constraintsDo: [ :c | c grid vertical alignCenter ].

	^ anEditor
]

{ #category : #'private - building' }
GtMagritteAsyncBuilderUtility class >> newFieldLabelWithSpace: aSpaceNumber using: aDescription [

	<return: #BrLabel>
	| aText |
	aText := aDescription label asRopedText.
	aDescription isRequired ifTrue: [ aText append: '*' asRopedText ].
	aText append: ':' asRopedText.

	^ BrLabel new
		  text: aText;
		  aptitude: (BrGlamorousLabelAptitude new foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  fitContent;
		  margin: (BlInsets
				   top: 0
				   right: (aSpaceNumber ifNil: [ self defaultSpaceNumber ])
				   bottom: (aSpaceNumber ifNil: [ self defaultSpaceNumber ])
				   left: 0);
		  constraintsDo: [ :c | c grid vertical alignTop ]
]

{ #category : #'api - ui' }
GtMagritteAsyncBuilderUtility class >> newValidationContainerWith: aFieldElement memento: aMemento using: aDescription [

	| aContainer anIssuesElement aChangeElement |
	aContainer := BrHorizontalGrid new.
	aContainer
		cellSpacing: 0;
		columnCount: 2;
		hFitContentLimited;
		vFitContent.

	aChangeElement := BrFrame new.
	aChangeElement hExact: self defaultThickness.
	aChangeElement vMatchParent.
	aChangeElement background: BrGlamorousColors textHighlightColor.
	aChangeElement visibility: BlVisibility hidden.
	aChangeElement margin: (BlInsets bottom: self defaultSpaceNumber).
	aChangeElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	aChangeElement withAsyncSinkDo: [ :anElementSink | 
		anElementSink
			sink: AsyncPeakSink new;
			whenUpdate: [ :aLabel :aSink | 
				| aValue |
				aValue := aSink value.
				aValue isChanged
					ifTrue: [ aLabel visibility: BlVisibility visible ]
					ifFalse: [ aLabel visibility: BlVisibility hidden ] ].
		(aMemento readObservableValueUsing: aDescription) observe:
			anElementSink ].

	anIssuesElement := BrEditor new.
	anIssuesElement
		aptitude: (BrGlamorousRegularEditorAptitude new
				 glamorousRegularFont;
				 glamorousCodeSmallSize;
				 foreground: BrGlamorousColors errorBackgroundColor);
		beReadOnlyWithSelection;
		hFitContentLimited;
		vFitContent;
		text: '';
		visibility: BlVisibility gone;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeakSink new;
				whenUpdate: [ :aLabel :aSink | 
					| aValue |
					aValue := aSink value.
					aValue isSuccess
						ifTrue: [ 
							aLabel
								text: '';
								visibility: BlVisibility gone ]
						ifFalse: [ 
							aLabel
								text: aValue issuesDescription;
								visibility: BlVisibility visible ] ].
			(aMemento validatorUsing: aDescription) observe: anElementSink ].

	aContainer addChild: aChangeElement as: #changeIndicator.
	aContainer addChild: aFieldElement as: #field.
	aContainer addChild: (BlElement new size: 0 @ 0) as: #placeHolder.
	aContainer addChild: anIssuesElement as: #issues.

	^ aContainer
]
