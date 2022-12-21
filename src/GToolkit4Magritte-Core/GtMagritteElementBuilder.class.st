Class {
	#name : #GtMagritteElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'memento',
		'form',
		'actions'
	],
	#category : #'GToolkit4Magritte-Core-Builders'
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

	| aCheckBoxElement aValidationElement aMemento aLabelElement aContainer aLabel |
	aMemento := self memento.
	aCheckBoxElement := GtMagritteBuilderUtility
		                    newCheckboxMemento: aMemento
		                    using: aDescription.

	aDescription hasCustomLabels
		ifFalse: [ aContainer := aCheckBoxElement ]
		ifTrue: [ 
			aLabelElement := GtMagritteBuilderUtility
				                 newBasicReadOnlyEditorWithMemento: aMemento
				                 using: aDescription.

			aLabelElement withAsyncSinkDo: [ :anElementSink | 
				anElementSink
					sink: AsyncPeekSink new;
					whenUpdate: [ :theEditor :aSink | 
						theEditor text:
								(aDescription labelForOption: aSink value currentValue) ].
				(aMemento readObservableValueUsing: aDescription) observe:
					anElementSink ].

			aContainer := BrHorizontalPane new
				              hFitContentLimited;
				              vFitContent;
				              alignCenterLeft.
			aContainer
				addChild: aCheckBoxElement;
				addChild: aLabelElement ].

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: aContainer
		                      memento: aMemento
		                      using: aDescription.

	aLabel := self
		          addFieldElement: aValidationElement
		          using: aDescription.

	aDescription hasCustomLabels ifTrue: [ 
		aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing) ]
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
GtMagritteElementBuilder >> addDirectoryDropdown: aDescription [

	| aMemento aButton aValidationElement |
	aMemento := self memento.


	aButton := GtMagritteBuilderUtility
		           newDirectoryDropdownMemento: aMemento
		           using: aDescription.

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: aButton
		                      memento: aMemento
		                      using: aDescription.

	self addFieldElement: aValidationElement using: aDescription
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

	self labelContainerDo: [ :aContainer | aContainer addChild: aLabel ].
	self fieldContainerDo: [ :aContainer | aContainer addChild: aFieldElement ].

	^ aLabel
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addFlowListUsing: aDescription [

	| aMemento aFlowElement |
	aMemento := self memento.
	
	aFlowElement := aDescription blocListStencil
		                memento: aMemento;
		                description: aDescription;
		                form: self form;
		                asElement.

	self addFieldElement: aFlowElement using: aDescription
]

{ #category : #visiting }
GtMagritteElementBuilder >> addIconUsing: aDescription [

	| aMemento anIcon |
	aMemento := self memento.

	anIcon := GtMagritteBuilderUtility
		          newIconWithMemento: aMemento
		          using: aDescription.

	self addFieldElement: anIcon using: aDescription
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addSingleOptionDropdownUsing: aDescription [

	| aMemento aButton aValidationElement |
	aMemento := self memento.


	aButton := GtMagritteBuilderUtility
		           newSingleOptionDropdownMemento: aMemento
		           using: aDescription.

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: aButton
		                      memento: aMemento
		                      using: aDescription.

	self addFieldElement: aValidationElement using: aDescription
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addStringFieldUsing: aDescription [

	| aMemento anInputElement aLabel aValidationElement |
	aMemento := self memento.

	aDescription blocStencil
		ifNotNil: [ :stencil | 
			anInputElement := stencil value: aMemento value: aDescription ]
		ifNil: [ 
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
								                  using: aDescription ] ] ].


	aDescription blocCompletion ifNotNil: [ :aStencil | 
		| aCompletionStrategy |
		aCompletionStrategy := aStencil
			                       memento: aMemento;
			                       description: aDescription;
			                       build.

		(GtCompletionController
			 on: anInputElement
			 strategy: aCompletionStrategy) install ].

	aDescription isWithChangeIndicator
		ifTrue: [ 
			aValidationElement := GtMagritteBuilderUtility
				                      newValidationContainerWith: anInputElement
				                      memento: aMemento
				                      using: aDescription ]
		ifFalse: [ aValidationElement := anInputElement ].

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
	self buildActions.
	self buildShortcuts
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> buildActions [

	| aToolbar |
	self hasActions ifFalse: [ ^ self ].
	
	self isReadOnlyForm ifTrue: [ ^ self ].

	self toolbarContainerDo: [ :aContainer |
	 
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

		aContainer addChild: aToolbar as: #toolbar ]
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> buildShortcuts [
	self form
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination tab;
				overrideChildren: true;
				action: [ :anEvent | 
					anEvent target fireEvent: (BrEditorAcceptWish new text: anEvent target text).
					anEvent target loseFocus ]).
	self form
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination enter;
				overrideChildren: true;
				action: [ :anEvent | 
					self memento overallStatus valueOrNil isValid
						ifTrue: [ [ self
								saveFrom: self form
								usingModel: self memento model
								andMemento: self memento ] asAsyncFuture await ] ]).
	self form
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination escape;
				overrideChildren: true;
				action: [ :anEvent | 
					[ self
						resetFrom: self form
						usingModel: self memento model
						andMemento: self memento ] asAsyncFuture await ]).
	self form
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination tab;
				overrideChildren: true;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionForward new;
						root: self form;
						referenceElement: anEvent target;
						nextFocusDo: #requestFocus ifNone: [  ] ])
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> defaultSpacing [

	^ GtMagritteBuilderUtility defaultSpaceNumber
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> fieldContainerDo: aBlock [

	self form magritte fieldContainerDo: aBlock
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

{ #category : #'private - building' }
GtMagritteElementBuilder >> isReadOnlyForm [
	^ self objectDescription children allSatisfy: #isReadOnly
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> labelContainerDo: aBlock [

	self form magritte labelContainerDo: aBlock
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
		installOn: [ :aModel :aButton :aMemento | 
			aButton
				withAsyncSinkDo: [ :anElementSink | 
					anElementSink
						sink: AsyncPeekSink new;
						whenUpdate: [ :theButton :aSink | 
							aSink value isChanged
								ifTrue: [ theButton enabled: true ]
								ifFalse: [ theButton enabled: false ] ].
					aMemento overallStatus observe: anElementSink ] ];
		action: [ :aModel :aButton :aMemento | 
			[ self
				resetFrom: aButton
				usingModel: aModel
				andMemento: aMemento ] asAsyncFuture await ]
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> newSaveButton [
	^ GtMagritteButtonWithIconAction new
		icon: BrGlamorousVectorIcons accept;
		tooltip: 'Save';
		installOn: [ :aModel :aButton :aMemento | 
			aButton
				withAsyncSinkDo: [ :anElementSink | 
					anElementSink
						sink: AsyncPeekSink new;
						whenUpdate: [ :theButton :aSink | 
							| aStatus |
							aStatus := aSink value.
							aStatus isChanged
								ifTrue: [ theButton enabled: aStatus isValid ]
								ifFalse: [ theButton enabled: false ] ].
					aMemento overallStatus observe: anElementSink ] ];
		action: [ :aModel :aButton :aMemento | 
			[ self
				saveFrom: aButton
				usingModel: aModel
				andMemento: aMemento ] asAsyncFuture await ]
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> objectDescription [

	^ self memento magritteDescription
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> resetFrom: aButton usingModel: aModel andMemento: aMemento [
	[ aMemento reset.
	(aModel magritteActions select: #isResetAction)
		do: [ :anAction | 
			anAction action
				cull: aModel
				cull: aButton
				cull: aMemento ] ]
		on: Error
		do: [ :anError | 
			(aModel magritteActions select: #isResetAction)
				do: [ :anAction | 
					anAction onErrorAction
						cull: aModel
						cull: aButton
						cull: aMemento ] ]
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> saveFrom: aButton usingModel: aModel andMemento: aMemento [
	[ aMemento commit.
	(aModel magritteActions select: #isCommitAction)
		do: [ :anAction | 
			anAction action
				cull: aModel
				cull: aButton
				cull: aMemento ] ]
		on: Error
		do: [ :anError | 
			(aModel magritteActions select: #isCommitAction)
				do: [ :anAction | 
					anAction onErrorAction
						cull: aModel
						cull: aButton
						cull: aMemento ] ]
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> toolbarContainerDo: aBlock [

	self form magritte toolbarContainerDo: aBlock
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitBooleanDescription: aDescription [

	self addBooleanField: aDescription
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitContainer: aDescription [

	aDescription do: [ :each | self visit: each ]
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitDirectoryDescription: aDescription [

	self addDirectoryDropdown: aDescription
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitIconDescription: aDescription [

	self addIconUsing: aDescription
]

{ #category : #accessing }
GtMagritteElementBuilder >> visitNumberDescription: aDescription [
	self visitStringDescription: aDescription
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitPictureDescription: aDescription [

	self addPictureUsing: aDescription
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitSingleOptionDescription: aDescription [
	self addSingleOptionDropdownUsing: aDescription
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitStringDescription: aDescription [

	self addStringFieldUsing: aDescription
]

{ #category : #'visiting-description' }
GtMagritteElementBuilder >> visitToManyRelationDescription: aDescription [

	self addFlowListUsing: aDescription
]
