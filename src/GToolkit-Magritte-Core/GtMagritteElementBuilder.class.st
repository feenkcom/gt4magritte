Class {
	#name : #GtMagritteElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'memento',
		'form',
		'actions'
	],
	#category : #'GToolkit-Magritte-Core-Builders'
}

{ #category : #accessing }
GtMagritteElementBuilder >> actions [

	^ actions
]

{ #category : #accessing }
GtMagritteElementBuilder >> actions: anObject [

	actions := anObject
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addBooleanField: aDescription [

	| anElement aValidationElement aMemento |
	aMemento := self memento.
	anElement := GtMagritteBuilderUtility
		             newCheckboxMemento: aMemento
		             using: aDescription.

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: anElement
		                      memento: aMemento
		                      using: aDescription.

	self addFieldElement: aValidationElement using: aDescription
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> addButtons [

	self addButtons: { 
			self newSaveButton.
			self newCancelButton }
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> addButtons: aCollection [

	"#addButtons: is part of the existing Morphic/Seaside API.
	We store the selectors instead of constructing the buttons to defer all element creation to first element access
	"

	self actions: (self actions copyWithAll: aCollection)
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addFieldElement: aFieldElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteBuilderUtility
		          newFieldLabelWithSpace: self defaultSpacing
		          using: aDescription.

	aDescription hasComment ifTrue: [ 
		GtMagritteBuilderUtility
			addCommentTooltip: aLabel
			using: aDescription.
		GtMagritteBuilderUtility
			addCommentTooltip: aFieldElement
			using: aDescription ].

	self form addChild: aLabel.
	self form addChild: aFieldElement.

	^ aLabel
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addFlowListUsing: aDescription [

	| aMemento aFlowElement aValidationElement |
	aMemento := self memento.

	aFlowElement := GtMagritteBuilderUtility
		                newFlowListMemento: aMemento
		                using: aDescription.

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: aFlowElement
		                      memento: aMemento
		                      using: aDescription.

	aValidationElement matchParent.
	self form matchParent.

	self addFieldElement: aValidationElement using: aDescription
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addStringFieldUsing: aDescription [

	| aMemento anInputElement aLabel aValidationElement |
	aMemento := self memento.

	aDescription isReadOnly
		ifTrue: [ 
			anInputElement := GtMagritteBuilderUtility
				                  newReadOnlyEditorWithMemento: aMemento
				                  using: aDescription ]
		ifFalse: [ 
			aDescription isAlwaysEditable
				ifFalse: [ 
					anInputElement := GtMagritteBuilderUtility
						                  newEditableLabelWithMemento: aMemento
						                  using: aDescription ]
				ifTrue: [ 
					anInputElement := GtMagritteBuilderUtility
						                  newOneLineEditorWithMemento: aMemento
						                  using: aDescription ].

			aDescription blocCompletion ifNotNil: [ :aStencil | 
				(GtCompletionController
					 on: anInputElement
					 strategy: aStencil create) install ] ].

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: anInputElement
		                      memento: aMemento
		                      using: aDescription.

	aLabel := self
		          addFieldElement: aValidationElement
		          using: aDescription.

	aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing)
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> build [

	self
		assert: [ self memento isNotNil ]
		description: [ 'Magritte must be defined' ].
	self
		assert: [ self objectDescription isNotNil ]
		description: [ 'Magritte description must be defined' ].

	self
		assert: [ self form isNotNil ]
		description: [ 'Form element must be defined' ].

	self visit: self objectDescription.
	self buildActions
	
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> buildActions [

	| aToolbar |
	self hasActions ifFalse: [ ^ self ].

	aToolbar := GtMagritteBuilderUtility
		            newToolbarWithActions: self actions
		            memento: self memento.

	self form
		when: BlMouseEnterEvent
		do: [ :anEvent | aToolbar visibility: BlVisibility visible ].

	self form
		when: BlMouseLeaveEvent
		do: [ :anEvent | aToolbar visibility: BlVisibility hidden ].

	aToolbar visibility: BlVisibility hidden.

	self form addChild: aToolbar as: #toolbar
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> defaultSpacing [

	^ GtMagritteBuilderUtility defaultSpaceNumber
]

{ #category : #accessing }
GtMagritteElementBuilder >> form [

	^ form
]

{ #category : #accessing }
GtMagritteElementBuilder >> form: anObject [

	form := anObject
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> hasActions [

	^ self actions isNotEmpty
]

{ #category : #initialization }
GtMagritteElementBuilder >> initialize [

	super initialize.

	actions := #(  )
]

{ #category : #accessing }
GtMagritteElementBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteElementBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> newCancelButton [

	^ GtMagritteButtonWithIconAction new
		  icon: BrGlamorousVectorIcons cancel;
		  tooltip: 'Cancel';
		  installOn: [ :aMemento :aButton | 
			  aButton withAsyncSinkDo: [ :anElementSink | 
					  anElementSink
						  sink: AsyncPeakSink new;
						  whenUpdate: [ :theButton :aSink | 
							  aSink value isChanged
								  ifTrue: [ theButton enabled: true ]
								  ifFalse: [ theButton enabled: false ] ].
					  aMemento overallStatus observe: anElementSink ] ];
		  action: [ :aMemento :aButton | 
		  [ aMemento reset ] asAsyncFuture await ]
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> newSaveButton [

	^ GtMagritteButtonWithIconAction new
		  icon: BrGlamorousVectorIcons accept;
		  tooltip: 'Save';
		  installOn: [ :aMemento :aButton | 
			  aButton withAsyncSinkDo: [ :anElementSink | 
					  anElementSink
						  sink: AsyncPeakSink new;
						  whenUpdate: [ :theButton :aSink | 
							  | aStatus |
							  aStatus := aSink value.
							  aStatus isChanged
								  ifTrue: [ theButton enabled: aStatus isValid ]
								  ifFalse: [ theButton enabled: false ] ].
					  aMemento overallStatus observe: anElementSink ] ];
		  action: [ :aMemento :aButton | 
		  [ aMemento commit ] asAsyncFuture await ]
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> objectDescription [

	^ self memento magritteDescription
]

{ #category : #visiting }
GtMagritteElementBuilder >> visitBooleanDescription: aDescription [

	self addBooleanField: aDescription
]

{ #category : #visiting }
GtMagritteElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #visiting }
GtMagritteElementBuilder >> visitStringDescription: aDescription [

	self addStringFieldUsing: aDescription
]

{ #category : #visiting }
GtMagritteElementBuilder >> visitToManyRelationDescription: aDescription [

	self addFlowListUsing: aDescription
]