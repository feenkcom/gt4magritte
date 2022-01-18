Class {
	#name : #GtMagritteNewEditableElementBuilder,
	#superclass : #GtMagritteNewElementBuilder,
	#instVars : [
		'form',
		'memento',
		'actions'
	],
	#category : #'GToolkit-Magritte-Builders'
}

{ #category : #'private - accessing' }
GtMagritteNewEditableElementBuilder >> actions [

	^ actions ifNil: [ #(  ) ]
]

{ #category : #'api - building' }
GtMagritteNewEditableElementBuilder >> actions: aCollection [

	actions := aCollection
]

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> addBooleanField: aDescription [

	| anElement |
	anElement := GtMagritteNewBuilderUtility
		             newCheckboxMemento: self memento
		             using: aDescription.

	self addFieldElement: anElement using: aDescription
]

{ #category : #'api - building' }
GtMagritteNewEditableElementBuilder >> addButtons [

	self addButtons: { 
			(GtMagritteButtonWithIconAction new
				 icon: BrGlamorousVectorIcons accept;
				 tooltip: 'Save';
				 installOn: [ :aMemento :aButton | 
					 | aHandler |
					 aHandler := GtMagritteElementValidChangesVisibilityHandler new
						             memento: aMemento;
						             element: aButton.
					 aMemento
						 when: GtMagritteMementoValueChangedAnnouncement
						 send: #onAnnouncement:
						 to: aHandler ];
				 action: [ :aMemento :aButton | 
					 aMemento validate then: [ :aResult | 
						 aResult isSuccess ifTrue: [ aMemento commit ] ] ]).

			(GtMagritteButtonWithIconAction new
				 icon: BrGlamorousVectorIcons cancel;
				 tooltip: 'Cancel';
				 installOn: [ :aMemento :aButton | 
					 | aHandler |
					 aHandler := GtMagritteElementValidChangesVisibilityHandler new
						             memento: aMemento;
						             element: aButton.
					 aMemento
						 when: GtMagritteMementoValueChangedAnnouncement
						 send: #onAnnouncement:
						 to: aHandler ];
				 action: [ :aMemento :aButton | aMemento reset ]) }
]

{ #category : #'api - building' }
GtMagritteNewEditableElementBuilder >> addButtons: aCollection [

	"#addButtons: is part of the existing Morphic/Seaside API.
	We store the selectors instead of constructing the buttons to defer all element creation to first element access
	"

	self actions: (aCollection collect: #asGtMagritteAction)
]

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> addFieldElement: aFieldElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteNewBuilderUtility
		          newFieldLabelWithSpace: self defaultSpacing
		          using: aDescription.

	aDescription hasComment ifTrue: [ 
		GtMagritteNewBuilderUtility
			addCommentTooltip: aLabel
			using: aDescription.
		GtMagritteNewBuilderUtility
			addCommentTooltip: aFieldElement
			using: aDescription ].

	self form addChild: aLabel.
	self form addChild: aFieldElement.

	^ aLabel
]

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> addFlowListUsing: aDescription [

	| aMemento aFlowElement |
	aMemento := self memento.

	aFlowElement := BrFlowList new matchParent.
	aFlowElement stencil: aDescription blocItemStencil.
	self form matchParent.
	self addFieldElement: aFlowElement using: aDescription.

	"aViewModels := [ (aMemento readUsing: aDescription) asAsyncStream ]
		               asAsyncFuture.
	aViewModels := aViewModels map: [ :aValue | 
		               aValue asGtMagritteNewViewModel ]."

	(aMemento readUsing: aDescription) then: [ :aResult | 
		aResult isSuccess ifTrue: [ 
			| aViewModels |
			aViewModels := aResult value collect: #asGtMagritteNewViewModel.

			"(aDescription definitive or: [ aDescription newItemStencil isNil ]) 
		ifFalse: [ 
			aViewModels := aViewModels copyWith:
				               (GtMagritteAddItemViewModel new
					                memento: aMemento;
					                description: aDescription;
					                stencil: aDescription newItemStencil;
					                items: aViewModels;
					                callback: [ :newItems | 
						                aFlowElement items: newItems ]) ]."

			"aFlowElement stream: aViewModels asAsyncStream."
			aFlowElement items: aViewModels ] ]
]

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> addStringFieldUsing: aDescription [

	| aMemento anInputElement aValidationElement aLabel |
	aMemento := self memento.

	aDescription isAlwaysEditable
		ifFalse: [ 
			anInputElement := GtMagritteNewBuilderUtility
				                  newEditableLabelWithSpace: self defaultSpacing
				                  memento: aMemento
				                  using: aDescription ]
		ifTrue: [ 
			anInputElement := GtMagritteNewBuilderUtility
				                  newOneLineEditorWithSpace: self defaultSpacing
				                  memento: aMemento
				                  using: aDescription ].

	aDescription blocCompletion ifNotNil: [ :aStencil | 
		(GtCompletionController on: anInputElement strategy: aStencil create)
			install ].

	aValidationElement := GtMagritteNewBuilderUtility
		                      newValidationContainerWith: anInputElement
		                      memento: aMemento
		                      using: aDescription.

	aLabel := self
		          addFieldElement: aValidationElement
		          using: aDescription.

	aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing)
]

{ #category : #'api - building' }
GtMagritteNewEditableElementBuilder >> asElement [

	<return: #BlElement>
	| aForm |
	self
		assert: [ self objectDescription isNotNil ]
		description: [ 'Magritte description must be defined' ].

	[ 
	self visit: self objectDescription.
	self buildActions.
	aForm := self form.
	aForm userData at: #magritteMemento put: self memento ] ensure: [ 
		form := nil ].

	^ aForm
]

{ #category : #'api - building' }
GtMagritteNewEditableElementBuilder >> buildActions [

	| aToolbar |
	self hasActions ifFalse: [ ^ self ].

	aToolbar := GtMagritteNewBuilderUtility
		            newToolbarWithActions: self actions
		            memento: self memento.

	aToolbar constraintsDo: [ :c | c grid horizontal span: 2 ].

	self form addChild: aToolbar as: #toolbar
]

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> createFormElement [

	^ BrHorizontalGrid new
		  columnCount: 2;
		  cellSpacing: 0;
		  padding: (BlInsets all: self defaultSpacing);
		  vFitContentLimited;
		  hFitContentLimited
]

{ #category : #'private - accessing' }
GtMagritteNewEditableElementBuilder >> defaultSpacing [

	^ GtMagritteNewBuilderUtility defaultSpaceNumber
]

{ #category : #'private - accessing' }
GtMagritteNewEditableElementBuilder >> form [

	^ form ifNil: [ form := self createFormElement ]
]

{ #category : #'private - testing' }
GtMagritteNewEditableElementBuilder >> hasActions [

	^ actions isNotNil and: [ actions isNotEmpty ]
]

{ #category : #'private - accessing' }
GtMagritteNewEditableElementBuilder >> memento [

	^ memento
]

{ #category : #'api - initialization' }
GtMagritteNewEditableElementBuilder >> memento: aMemento [

	self
		assert: [ memento isNil ]
		description: [ 'Memento can be initialized only once' ].

	memento := aMemento
]

{ #category : #'private - accessing' }
GtMagritteNewEditableElementBuilder >> objectDescription [

	^ self memento description
]

{ #category : #visiting }
GtMagritteNewEditableElementBuilder >> visitBooleanDescription: aDescription [

	self addBooleanField: aDescription
]

{ #category : #visiting }
GtMagritteNewEditableElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #visiting }
GtMagritteNewEditableElementBuilder >> visitStringDescription: aDescription [

	self addStringFieldUsing: aDescription
]

{ #category : #visiting }
GtMagritteNewEditableElementBuilder >> visitToManyRelationDescription: aDescription [

	self addFlowListUsing: aDescription
]
