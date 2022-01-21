Class {
	#name : #GtMagritteAsyncElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'memento',
		'form'
	],
	#category : #'GToolkit-Magritte-New-Builders'
}

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> addBooleanField: aDescription [

	| anElement aValidationElement aMemento |
	aMemento := self memento.
	anElement := GtMagritteAsyncBuilderUtility
		             newCheckboxMemento: aMemento
		             using: aDescription.

	aValidationElement := GtMagritteAsyncBuilderUtility
		                      newValidationContainerWith: anElement
		                      memento: aMemento
		                      using: aDescription.

	self addFieldElement: aValidationElement using: aDescription
]

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> addFieldElement: aFieldElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteAsyncBuilderUtility
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
GtMagritteAsyncElementBuilder >> addFlowListUsing: aDescription [

	| aMemento aFlowElement |
	aMemento := self memento.

	aFlowElement := GtMagritteAsyncBuilderUtility
		                newFlowListMemento: aMemento
		                using: aDescription.

	self form matchParent.

	self addFieldElement: aFlowElement using: aDescription
]

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> addStringFieldUsing: aDescription [

	| aMemento anInputElement aLabel aValidationElement |
	aMemento := self memento.

	aDescription isAlwaysEditable
		ifFalse: [ 
			anInputElement := GtMagritteAsyncBuilderUtility
				                  newEditableLabelWithMemento: aMemento
				                  using: aDescription ]
		ifTrue: [ 
			anInputElement := GtMagritteAsyncBuilderUtility
				                  newOneLineEditorWithMemento: aMemento
				                  using: aDescription ].

	aDescription blocCompletion ifNotNil: [ :aStencil | 
		(GtCompletionController on: anInputElement strategy: aStencil create)
			install ].

	aValidationElement := GtMagritteAsyncBuilderUtility
		                      newValidationContainerWith: anInputElement
		                      memento: aMemento
		                      using: aDescription.

	aLabel := self
		          addFieldElement: aValidationElement
		          using: aDescription.

	aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing)
]

{ #category : #'api - building' }
GtMagritteAsyncElementBuilder >> build [

	self
		assert: [ self memento isNotNil ]
		description: [ 'Magritte must be defined' ].
	self
		assert: [ self objectDescription isNotNil ]
		description: [ 'Magritte description must be defined' ].

	self
		assert: [ self form isNotNil ]
		description: [ 'Form element must be defined' ].

	self visit: self objectDescription
]

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> defaultSpacing [

	^ GtMagritteAsyncBuilderUtility defaultSpaceNumber
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> form [

	^ form
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> form: anObject [

	form := anObject
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'private - accessing' }
GtMagritteAsyncElementBuilder >> objectDescription [

	^ self memento magritteDescription
]

{ #category : #visiting }
GtMagritteAsyncElementBuilder >> visitBooleanDescription: aDescription [

	self addBooleanField: aDescription
]

{ #category : #visiting }
GtMagritteAsyncElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #visiting }
GtMagritteAsyncElementBuilder >> visitStringDescription: aDescription [

	self addStringFieldUsing: aDescription
]

{ #category : #visiting }
GtMagritteAsyncElementBuilder >> visitToManyRelationDescription: aDescription [

	self addFlowListUsing: aDescription
]
