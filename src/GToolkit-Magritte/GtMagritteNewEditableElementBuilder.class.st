Class {
	#name : #GtMagritteNewEditableElementBuilder,
	#superclass : #GtMagritteNewElementBuilder,
	#instVars : [
		'form',
		'memento'
	],
	#category : #'GToolkit-Magritte-Builders'
}

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> addFieldElement: aFieldElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteNewBuilderUtility
		          newFieldLabelWithSpace: self defaultSpacing
		          using: aDescription.

	aLabel padding: aLabel padding
		+ (BlInsets top: self defaultSpacing ).

	aDescription hasComment ifTrue: [ 
		GtMagritteNewBuilderUtility
			addCommentTooltip: aLabel
			using: aDescription.
		GtMagritteNewBuilderUtility
			addCommentTooltip: aFieldElement
			using: aDescription ].

	self form addChild: aLabel.
	self form addChild: aFieldElement
]

{ #category : #'private - building' }
GtMagritteNewEditableElementBuilder >> addStringFieldUsing: aDescription [

	| aMemento anInputElement aValidationElement |
	aMemento := self memento.

	anInputElement := GtMagritteNewBuilderUtility
		                  newEditableLabelWithSpace: self defaultSpacing
		                  memento: aMemento
		                  using: aDescription.

	aValidationElement := GtMagritteNewBuilderUtility
		newValidationContainerWith: anInputElement
		memento: aMemento
		using: aDescription.
		
	self addFieldElement: aValidationElement using: aDescription
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
	aForm := self form.
	aForm userData at: #magritteMemento put: self memento ] ensure: [ 
		form := nil ].

	^ aForm
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
GtMagritteNewEditableElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #visiting }
GtMagritteNewEditableElementBuilder >> visitStringDescription: aDescription [

	self addStringFieldUsing: aDescription
]
