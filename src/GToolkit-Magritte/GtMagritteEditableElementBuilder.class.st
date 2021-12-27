Class {
	#name : #GtMagritteEditableElementBuilder,
	#superclass : #GtMagritteElementBuilder,
	#instVars : [
		'actions'
	],
	#category : #'GToolkit-Magritte-Core'
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
GtMagritteEditableElementBuilder >> addInputField: anInputElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteBuilderUtility
		          newFieldLabelWithSpace: nil
		          using: aDescription.

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

	| anInputElement |
	anInputElement := GtMagritteBuilderUtility
		                  newEditableLabelWithSpace: nil
		                  memento: self memento
		                  using: aDescription.

	anInputElement when: GtMagritteAcceptWish do: [ :anEvent | 
		anEvent consumed: true.
		anEvent currentTarget acceptEdition. ].

	anInputElement when: GtMagritteCancelWish do: [ :anEvent | 
		anEvent consumed: true.
		anEvent currentTarget cancelEdition.
		anEvent currentTarget text: (GtMagritteBuilderUtility
				 readString: aDescription
				 from: anEvent memento) ].
				 
	self presenter addElement: anInputElement.

	self addInputField: anInputElement using: aDescription
]

{ #category : #converting }
GtMagritteEditableElementBuilder >> asElement [

	<return: #BlElement>
	| anElement aForm |
	aForm := super asElement.
	self hasActions ifFalse: [ ^ aForm ].

	anElement := BrVerticalPane new
		             vFitContent;
		             hMatchParent;
		             addChild: aForm;
		             yourself.

	anElement userData at: #magrittePresenter put: self presenter.

	anElement addChild: (GtMagritteBuilderUtility
			 newToolbarWithActions: self actions
			 presenter: self presenter).

	^ anElement
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
