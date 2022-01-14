Class {
	#name : #GtMagritteBuilderUtility,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> addCommentTooltip: anElement using: aDescription [

	| aText |
	aText := aDescription comment asRopedText.

	aDescription isRequired ifTrue: [ 
		aText append: ' (required)' asRopedText ].

	anElement addAptitude:
		(BrGlamorousWithLabelTooltipAptitude new text: aText)
]

{ #category : #'api - magritte' }
GtMagritteBuilderUtility class >> computeMementoForObject: anObject description: aDescription [

	| aResult aMemento |
	[ 
	aMemento := anObject mementoClass
		            model: anObject
		            description: aDescription ]
		on: Error
		do: [ :anError | 
			aResult := GtMagritteMementoCreationFailure new
				           object: anObject;
				           description: aDescription ].

	^ aResult ifNil: [ 
		  GtMagritteMementoCreationSuccess new
			  memento: aMemento;
			  object: anObject;
			  description: aDescription ]
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> defaultSpaceNumber [

	^ 5
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newEditableLabelWithSpace: aSpaceNumber memento: aMemento using: aDescription [

	^ BrEditableLabel new
		  aptitude:
			  BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		  vFitContent;
		  hFitContentLimited;
		  when: BrEditorAcceptWish do: [ :aWish | 
			  self
				  writeString: aDescription
				  value: aWish text greaseString
				  to: aMemento ];
		  text: (self readString: aDescription from: aMemento);
		  margin:
			  (BlInsets bottom:
					   (aSpaceNumber ifNil: [ self defaultSpaceNumber ]));
		  constraintsDo: [ :c | c grid vertical alignCenter ]
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newFieldLabelWithSpace: aSpaceNumber using: aDescription [

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
GtMagritteBuilderUtility class >> newLabelWithSpace: aSpaceNumber memento: aMemento using: aDescription [

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
GtMagritteBuilderUtility class >> newToolbarWithActions: aCollection presenter: aPresenter [

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

{ #category : #'api - magritte' }
GtMagritteBuilderUtility class >> readString: aDescription from: aMemento [

	<return: #BlText>
	| aValue |
	aValue := aDescription readToString: aMemento.
	^ aValue asRopedText glamorousRegularFontAndSize
]

{ #category : #'api - magritte' }
GtMagritteBuilderUtility class >> writeString: aDescription value: aValue to: aMemento [

	aDescription writeFromString: aValue greaseString to: aMemento
]
