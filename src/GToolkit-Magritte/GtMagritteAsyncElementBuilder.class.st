Class {
	#name : #GtMagritteAsyncElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'memento',
		'form',
		'actions'
	],
	#category : #'GToolkit-Magritte-Builders'
}

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> actions [

	^ actions
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> actions: anObject [

	actions := anObject
]

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

{ #category : #'api - building' }
GtMagritteAsyncElementBuilder >> addButtons [

	self addButtons: { 
			self newSaveButton.
			self newCancelButton }
]

{ #category : #'api - building' }
GtMagritteAsyncElementBuilder >> addButtons: aCollection [

	"#addButtons: is part of the existing Morphic/Seaside API.
	We store the selectors instead of constructing the buttons to defer all element creation to first element access
	"

	self actions: (self actions copyWithAll: aCollection)
]

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> addFieldElement: aFieldElement using: aDescription [

	| aLabel |
	aLabel := GtMagritteAsyncBuilderUtility
		          newFieldLabelWithSpace: self defaultSpacing
		          using: aDescription.

	aDescription hasComment ifTrue: [ 
		GtMagritteAsyncBuilderUtility
			addCommentTooltip: aLabel
			using: aDescription.
		GtMagritteAsyncBuilderUtility
			addCommentTooltip: aFieldElement
			using: aDescription ].

	self form addChild: aLabel.
	self form addChild: aFieldElement.

	^ aLabel
]

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> addFlowListUsing: aDescription [

	| aMemento aFlowElement aValidationElement |
	aMemento := self memento.

	aFlowElement := GtMagritteAsyncBuilderUtility
		                newFlowListMemento: aMemento
		                using: aDescription.

	aValidationElement := GtMagritteAsyncBuilderUtility
		                      newValidationContainerWith: aFlowElement
		                      memento: aMemento
		                      using: aDescription.

	aValidationElement matchParent.
	self form matchParent.

	self addFieldElement: aValidationElement using: aDescription
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

	self visit: self objectDescription.
	self buildActions
	
]

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> buildActions [

	| aToolbar |
	self hasActions ifFalse: [ ^ self ].

	aToolbar := GtMagritteAsyncBuilderUtility
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

{ #category : #'private - building' }
GtMagritteAsyncElementBuilder >> hasActions [

	^ self actions isNotEmpty
]

{ #category : #initialization }
GtMagritteAsyncElementBuilder >> initialize [

	super initialize.

	actions := #(  )
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteAsyncElementBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - building' }
GtMagritteAsyncElementBuilder >> newCancelButton [

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
GtMagritteAsyncElementBuilder >> newSaveButton [

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
