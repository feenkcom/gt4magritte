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

	^ 4
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> defaultThickness [

	^ 3
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> enqueueAction: aBlock into: anElement [

	anElement enqueueTask: (BlTaskAction new action: aBlock)
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

	aMemento
		when: GtMagritteMementoValueChangedAnnouncement
		send: #onAnnouncement:
		to: (GtMagritteValueChangedEditableEditorHandler new
				 memento: aMemento;
				 description: aDescription;
				 editorElement: anEditor).
		
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
GtMagritteNewBuilderUtility class >> newOneLineEditorWithSpace: aSpaceNumber memento: aMemento using: aDescription [

	| anEditor |
	anEditor := BrEditor new.

	anEditor
		aptitude:
			BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize;
		vFitContent;
		hFitContentLimited;
		margin:
			(BlInsets bottom: (aSpaceNumber ifNil: [ self defaultSpaceNumber ]));
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ].

	anEditor editor when: BrTextEditorModifiedEvent do: [ :anEvent | 
		| aPromise |
		aPromise := self
			            writeString: aDescription
			            value: anEvent text greaseString
			            to: aMemento.
		aPromise then: [ :aResult | 
			aMemento validationPromiseUsing: aDescription ] ].

	aMemento
		when: GtMagritteMementoValueChangedAnnouncement
		send: #onAnnouncement:
		to: (GtMagritteValueChangedEditableEditorHandler new
				 memento: aMemento;
				 description: aDescription;
				 editorElement: anEditor).

	self readString: aDescription from: aMemento intoEditor: anEditor.

	^ anEditor
]

{ #category : #'api - building' }
GtMagritteNewBuilderUtility class >> newToolbarWithActions: aCollection memento: aMemento [

	| aToolbar |
	aToolbar := BrToolbar new
		            aptitude: BrGlamorousToolbarAptitude new;
		            fitContent;
		            constraintsDo: [ :c | 
			            c grid horizontal alignLeft.
			            c linear horizontal alignLeft ].

	aCollection do: [ :eachAction | 
		| aButton |
		aButton := eachAction asBlockButtonWithMemento: aMemento.
		aToolbar addItem: aButton ].

	^ aToolbar
]

{ #category : #'api - ui' }
GtMagritteNewBuilderUtility class >> newValidationContainerWith: aFieldElement memento: aMemento using: aDescription [

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

	aMemento
		when: GtMagritteMementoValueChangedAnnouncement
		send: #onAnnouncement:
		to: (GtMagritteValueChangedIndicatorHandler new
				 memento: aMemento;
				 description: aDescription;
				 indicatorElement: aChangeElement;
				 update).

	aMemento
		when: GtMagritteMementoCommittedAnnouncement
		send: #onAnnouncement:
		to: (GtMagritteCommittedIndicatorHandler new
				 memento: aMemento;
				 description: aDescription;
				 indicatorElement: aChangeElement).

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

	aContainer addChild: aChangeElement as: #changeIndicator.
	aContainer addChild: aFieldElement as: #field.
	aContainer addChild: (BlElement new size: 0 @ 0) as: #placeHolder.
	aContainer addChild: anIssuesElement as: #issues.

	aMemento
		when: GtMagritteMementoDescriptionValidationChangedAnnouncement
		send: #onAnnouncement:
		to: (GtMagritteDescriptionValidationHandler new
				 memento: aMemento;
				 description: aDescription;
				 editorElement: anIssuesElement;
				 update).

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
