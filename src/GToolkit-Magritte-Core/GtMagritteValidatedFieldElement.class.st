Class {
	#name : #GtMagritteValidatedFieldElement,
	#superclass : #BrHorizontalGrid,
	#instVars : [
		'changeElement',
		'issuesElement',
		'memento',
		'description',
		'fieldElement'
	],
	#category : #'GToolkit-Magritte-Core-Widgets'
}

{ #category : #initialization }
GtMagritteValidatedFieldElement >> defaultSpaceNumber [

	^ GtMagritteBuilderUtility defaultSpaceNumber
]

{ #category : #initialization }
GtMagritteValidatedFieldElement >> defaultThickness [

	^ GtMagritteBuilderUtility defaultThickness
]

{ #category : #initialization }
GtMagritteValidatedFieldElement >> initialize [

	super initialize.
	self cellSpacing: 0.
	self columnCount: 2.
	self hFitContentLimited.
	self vFitContent.

	changeElement := self newChangeElement.
	fieldElement := self newPlaceHolderElement.
	issuesElement := self newIssuesElement.

	self addChild: changeElement as: #changeIndicator.
	self addChild: fieldElement as: #field.
	self addChild: self newPlaceHolderElement as: #empty.
	self addChild: issuesElement as: #issues
]

{ #category : #accessing }
GtMagritteValidatedFieldElement >> memento: aMemento description: aDescription element: aFieldElement [

	memento := aMemento.
	description := aDescription.

	changeElement withAsyncSinkDo: [ :anElementSink | 
		(aMemento readObservableValueUsing: aDescription) observe:
			anElementSink ].
	issuesElement withAsyncSinkDo: [ :anElementSink | 
		(aMemento validatorUsing: aDescription) observe: anElementSink ].

	self replaceChild: fieldElement with: aFieldElement as: #field.
	fieldElement := aFieldElement.
]

{ #category : #initialization }
GtMagritteValidatedFieldElement >> newChangeElement [

	^ BrFrame new
		  hExact: self defaultThickness;
		  vMatchParent;
		  background: BrGlamorousColors textHighlightColor;
		  visibility: BlVisibility hidden;
		  margin: (BlInsets bottom: self defaultSpaceNumber);
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		  withAsyncSinkDo: [ :anElementSink | 
			  anElementSink
				  sink: AsyncPeakSink new;
				  whenUpdate: [ :aLabel :aSink | 
					  | aValue |
					  aValue := aSink value.
					  aValue isChanged
						  ifTrue: [ aLabel visibility: BlVisibility visible ]
						  ifFalse: [ aLabel visibility: BlVisibility hidden ] ] ]
]

{ #category : #initialization }
GtMagritteValidatedFieldElement >> newIssuesElement [

	^ BrEditor new
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
								  visibility: BlVisibility visible ] ] ]
]

{ #category : #initialization }
GtMagritteValidatedFieldElement >> newPlaceHolderElement [

	^ BlElement new size: 0 @ 0
]
