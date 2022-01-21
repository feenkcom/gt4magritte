Class {
	#name : #GtMagritteReadOnlyElementBuilder,
	#superclass : #GtMagritteElementBuilder,
	#category : #'GToolkit-Magritte-FirstImplementation'
}

{ #category : #'private - building' }
GtMagritteReadOnlyElementBuilder >> addInputField: anInputElement using: aDescription [

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
GtMagritteReadOnlyElementBuilder >> addInputFieldUsing: aDescription [

	| anInputElement |
	anInputElement := GtMagritteBuilderUtility
		                  newLabelWithSpace: nil
		                  memento: self memento
		                  using: aDescription.

	self addInputField: anInputElement using: aDescription
]

{ #category : #visiting }
GtMagritteReadOnlyElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #visiting }
GtMagritteReadOnlyElementBuilder >> visitStringDescription: aDescription [

	self addInputFieldUsing: aDescription
]
