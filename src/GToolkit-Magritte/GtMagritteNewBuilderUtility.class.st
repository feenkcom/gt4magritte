Class {
	#name : #GtMagritteNewBuilderUtility,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> addCommentTooltip: anElement using: aDescription [

	| aText |
	aText := aDescription comment asRopedText.

	aDescription isRequired ifTrue: [ 
		aText append: ' (required)' asRopedText ].

	anElement addAptitude:
		(BrGlamorousWithLabelTooltipAptitude new text: aText)
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> defaultSpaceNumber [

	^ 5
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> newEditableLabelWithSpace: aSpaceNumber memento: aMemento using: aDescription [

	| anEditor |
	anEditor := BrEditableLabel new.

	anEditor
		aptitude:
			BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		vFitContent;
		hFitContentLimited;
		when: BrEditorAcceptWish do: [ :aWish | 
			| aPromise |
			aPromise := self
				            writeString: aDescription
				            value: aWish text greaseString
				            to: aMemento.
			aPromise then: [ :aResult | 
					aMemento validationPromiseUsing: aDescription ] ];
		margin:
			(BlInsets bottom: (aSpaceNumber ifNil: [ self defaultSpaceNumber ]));
		constraintsDo: [ :c | c grid vertical alignCenter ].

	self readString: aDescription from: aMemento intoEditor: anEditor.

	^ anEditor
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> newFieldLabelWithSpace: aSpaceNumber using: aDescription [

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
GtMagritteNewBuilderUtility class >> newLabelWithSpace: aSpaceNumber memento: aMemento using: aDescription [

	^ BrLabel new
		  aptitude: BrGlamorousLabelAptitude new glamorousRegularFontAndSize;
		  vFitContent;
		  hFitContentLimited;
		  text: (self readString: aDescription from: aMemento);
		  margin:
			  (BlInsets bottom:
					   (aSpaceNumber ifNil: [ self defaultSpaceNumber ]));
		  constraintsDo: [ :c | c grid vertical alignCenter ]
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> newToolbarWithActions: aCollection presenter: aPresenter [

	| aToolbar |
	aToolbar := BrToolbar new
		            aptitude: BrGlamorousToolbarAptitude new;
		            fitContent;
		            constraintsDo: [ :c | 
			            c grid horizontal alignLeft.
			            c linear horizontal alignLeft ].

	aCollection do: [ :eachAction | 
		| aButton |
		aButton := eachAction asBlocButtonWithPresenter: aPresenter.
		aToolbar addItem: aButton ].

	^ aToolbar
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> newValidationContainerWith: aFieldElement memento: aMemento using: aDescription [

	| aContainer anIssuesElement |
	aContainer := BrVerticalPane new.
	aContainer
		hFitContentLimited;
		vFitContent.

	anIssuesElement := BrEditor new
		                   aptitude: (BrGlamorousRegularEditorAptitude new
				                    glamorousRegularFont;
				                    glamorousCodeSmallSize;
				                    foreground:
					                    BrGlamorousColors errorBackgroundColor);
		                   beReadOnlyWithSelection;
		                   hFitContentLimited;
		                   vFitContent;
		                   text: '';
		                   visibility: BlVisibility gone.

	aContainer addChild: aFieldElement as: #field.
	aContainer addChild: anIssuesElement as: #issues.

	aMemento
		when: GtMagritteMementoDescriptionValidationChangedAnnouncement
		send: #onAnnouncement:
		to: (GtMagritteDescriptionValidationHandler new
				 memento: aMemento;
				 description: aDescription;
				 editorElement: anIssuesElement).

	^ aContainer
]

{ #category : #'api - memento' }
GtMagritteNewBuilderUtility class >> readString: aDescription from: aMemento intoEditor: anEditor [

	| aPromise |
	aPromise := aMemento readPromiseUsing: aDescription.

	^ aPromise then: [ :aResult | 
		  aResult isSuccess ifTrue: [ 
			  anEditor enqueueTask:
				  (BlTaskAction new action: [ anEditor text: aResult value ]) ] ]
]

{ #category : #'api - memento' }
GtMagritteNewBuilderUtility class >> writeString: aDescription value: aText to: aMemento [ 

	| aPromise aString |
	aString := aText asString.
	aPromise := aMemento writePromise: aString using: aDescription.
	
	^ aPromise
]
