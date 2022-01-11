Class {
	#name : #GtMagritteEditableElementBuilder,
	#superclass : #GtMagritteElementBuilder,
	#instVars : [
		'actions',
		'element'
	],
	#category : #'GToolkit-Magritte-Builders'
}

{ #category : #accessing }
GtMagritteEditableElementBuilder >> actions [

	^ actions ifNil: [ #(  ) ]
]

{ #category : #accessing }
GtMagritteEditableElementBuilder >> actions: anObject [

	actions := anObject
]

{ #category : #accessing }
GtMagritteEditableElementBuilder >> addButtons [

	self addButtons: #( save cancel )
]

{ #category : #accessing }
GtMagritteEditableElementBuilder >> addButtons: aCollection [

	"#addButtons: is part of the existing Morphic/Seaside API.
	We store the selectors instead of constructing the buttons to defer all element creation to first element access
	"

	self actions: (aCollection collect: #asGtMagritteAction)
]

{ #category : #'private - building' }
GtMagritteEditableElementBuilder >> addFlowListUsing: aDescription [

	| aContainerViewModel aMemento anElement |
	aContainerViewModel := GtMagritteFieldWithValidationErrorsViewModel
		                       new.
	aContainerViewModel description: aDescription.
	aMemento := self memento.
	aContainerViewModel memento: aMemento.

	aContainerViewModel fieldStencil: [ 
		| aGridElement aViewModels |
		aGridElement := BrFlowList new matchParent.
		aViewModels := (aMemento readUsing: aDescription) collect:
			               #asGtMagritteViewModel.

		(aDescription definitive or: [ aDescription newItemStencil isNil ]) 
			ifFalse: [ 
				aViewModels := aViewModels copyWith: ((GtMagritteAddItemViewModel new
					memento: aMemento;
					description: aDescription;
					stencil: aDescription newItemStencil;
					items: aViewModels;
					callback: [ :newItems | aGridElement items: newItems ])) ].

		aGridElement items: aViewModels.

		aGridElement stencil: aDescription blocItemStencil.

		aGridElement when: GtMagritteValueUpdateWish do: [ :anEvent | 
			anEvent consumed: true.
			anEvent currentTarget items: anEvent value ].



		aGridElement ].

	self presenter addViewModel: aContainerViewModel.
	anElement := aContainerViewModel asElement.
	anElement matchParent.

	self form matchParent.
	self element matchParent.

	self addInputField: anElement using: aDescription
]

{ #category : #'private - building' }
GtMagritteEditableElementBuilder >> addInputField: anInputElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteBuilderUtility
		          newFieldLabelWithSpace: nil
		          using: aDescription.

	aLabel padding: aLabel padding + (BlInsets top: 5).

	aDescription hasComment ifTrue: [ 
		GtMagritteBuilderUtility
			addCommentTooltip: aLabel
			using: aDescription.
		GtMagritteBuilderUtility
			addCommentTooltip: anInputElement
			using: aDescription ].

	self form addChild: aLabel.
	self form addChild: anInputElement
]

{ #category : #'private - building' }
GtMagritteEditableElementBuilder >> addInputFieldUsing: aDescription [

	| anInputElement aContainerViewModel aMemento |
	aContainerViewModel := GtMagritteFieldWithValidationErrorsViewModel
		                       new.
	aContainerViewModel description: aDescription.
	aMemento := self memento.
	aContainerViewModel memento: aMemento.

	aContainerViewModel fieldStencil: [ 
		anInputElement := GtMagritteBuilderUtility
			                  newEditableLabelWithSpace: nil
			                  memento: aMemento
			                  using: aDescription.

		anInputElement
			when: GtMagritteValueUpdateWish
			do: [ :anEvent | 
				anEvent consumed: true.
				anEvent currentTarget cancelEdition.
				anEvent currentTarget text: anEvent value ].

		aDescription blocCompletion ifNotNil: [ :aStencil | 
			(GtCompletionController
				 on: anInputElement
				 strategy: aStencil create) install ].

		anInputElement ].

	self presenter addViewModel: aContainerViewModel.

	self addInputField: aContainerViewModel asElement using: aDescription
]

{ #category : #converting }
GtMagritteEditableElementBuilder >> asElement [

	<return: #BlElement>
	| aForm aPresenter anElement |
	anElement := BrVerticalPane new fitContent.
	element := anElement.

	aForm := super asElement.
	self hasActions ifFalse: [ ^ aForm ].

	anElement addChild: aForm.

	aPresenter := aForm userData at: #magrittePresenter.
	anElement userData at: #magrittePresenter put: aPresenter.

	anElement addChild: (GtMagritteBuilderUtility
			 newToolbarWithActions: self actions
			 presenter: aPresenter).

	element := nil.

	^ anElement
]

{ #category : #'private - accessing' }
GtMagritteEditableElementBuilder >> element [

	^ element
]

{ #category : #'gt - extensions' }
GtMagritteEditableElementBuilder >> gtActionsFor: aView [

	<gtView>
	^ aView list
		  title: 'Actions';
		  priority: 20;
		  items: [ self actions ]
]

{ #category : #testing }
GtMagritteEditableElementBuilder >> hasActions [

	^ self actions isNotEmpty
]

{ #category : #visiting }
GtMagritteEditableElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #visiting }
GtMagritteEditableElementBuilder >> visitStringDescription: aDescription [

	self addInputFieldUsing: aDescription
]

{ #category : #visiting }
GtMagritteEditableElementBuilder >> visitToManyRelationDescription: aDescription [

	self addFlowListUsing: aDescription
]
