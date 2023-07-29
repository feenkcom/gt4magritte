Class {
	#name : #GtMagritteElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'memento',
		'form',
		'explicitActions'
	],
	#category : #'GToolkit4Magritte-Core-Builders'
}

{ #category : #accessing }
GtMagritteElementBuilder >> actions [

	^ explicitActions
]

{ #category : #accessing }
GtMagritteElementBuilder >> actions: anObject [

	explicitActions := anObject
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addBooleanField: aDescription [
	| aCheckBoxElement aValidationElement aMemento aLabel |
	
	aMemento := self memento.
	
	aDescription blocStencil
		ifNotNil: [ :stencil | 
			aCheckBoxElement := stencil 
				memento: aMemento; 
				description: aDescription;
				asElement ]
		ifNil: [ 
			aCheckBoxElement := GtMagritteBooleanElement new
				fieldViewModel: (GtMagritteFieldViewModel new
						memento: aMemento;
						description: aDescription) ].

	aValidationElement := GtMagritteBuilderUtility
		                      newValidationContainerWith: aCheckBoxElement
		                      memento: aMemento
		                      using: aDescription.

	aLabel := self
		          addFieldElement: aValidationElement
		          using: aDescription.

	aDescription hasCustomLabels ifTrue: [ 
		aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing) ]
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
GtMagritteElementBuilder >> addShortcutsTo: anElement [
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Discard form contents';
				description: 'Discards the form contents and resets the form to its original state';
				combination: BlKeyCombination escape;
				overrideChildren: true;
				action: [ :anEvent | 
					[ self
						resetFrom: self form
						usingModel: self memento model
						andMemento: self memento ] asAsyncFuture await ]).
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Move to next form item';
				description: 'Moves to the next form item. If none is found, we cycle back to the first.';
				combination: (BlKeyCombination tab or: BlKeyCombination enter);
				overrideChildren: true;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionForward new;
						root: self form;
						referenceElement: anEvent target;
						nextFocusDo: #requestFocus ifNone: [  ] ]).
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Move to previous form item';
				description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
				combination: BlKeyCombination shiftTab;
				overrideChildren: true;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionBackward new;
						root: self form;
						referenceElement: anEvent target;
						nextFocusDo: #requestFocus ifNone: [  ] ])
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addShortcutsTo: anElement using: aDescription [
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Discard form contents';
				description: 'Discards the form contents and resets the form to its original state';
				combination: BlKeyCombination escape;
				overrideChildren: true;
				action: [ :anEvent | 
					[ self
						resetFrom: self form
						usingModel: self memento model
						andMemento: self memento ] asAsyncFuture await ]).
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Move to next form item';
				description: 'Moves to the next form item. If none is found, we cycle back to the first.';
				combination: (BlKeyCombination tab or: BlKeyCombination enter);
				overrideChildren: true;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionForward new;
						root: self form;
						referenceElement: anEvent target;
						nextFocusDo: #requestFocus ifNone: [  ] ]).
	anElement
		addShortcut: (BlShortcutWithAction new
				name: 'Move to previous form item';
				description: 'Moves to the previous form item. If none is found, we cycle back to the last.';
				combination: BlKeyCombination shiftTab;
				overrideChildren: true;
				action: [ :anEvent | 
					BlFocusFinder new
						direction: BlFocusSearchDirectionBackward new;
						root: self form;
						referenceElement: anEvent target;
						nextFocusDo: #requestFocus ifNone: [  ] ]).

	aDescription blocShortcuts
		ifNotNil: [ :aBlockReturningCollection | aBlockReturningCollection value do: [ :aShortcut | anElement addShortcut: aShortcut ] ]
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> addSingleOptionDropdownUsing: aDescription [

	| aMemento aButton aValidationElement |
	aMemento := self memento.


	aButton := GtMagritteBuilderUtility
		           newSingleOptionDropdownMemento: aMemento
		           using: aDescription.
		           
	self addShortcutsTo: aButton.

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
			anInputElement := stencil 
				memento: aMemento; 
				description: aDescription;
				asElement ]
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

	self addShortcutsTo: anInputElement using: aDescription.

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

	aLabel padding: aLabel padding + (BlInsets top: self defaultSpacing).
	
	^ anInputElement
]

{ #category : #accessing }
GtMagritteElementBuilder >> allActions [
	| allActions |
	allActions := self actions , self implicitActions.

	allActions sort: [ :a :b | a priority < b priority ].

	^ allActions
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
	| aToolbar allActions |
	allActions := self allActions.
	allActions ifEmpty: [ ^ self ].

	self
		toolbarContainerDo: [ :aContainer | 
			aToolbar := GtMagritteBuilderUtility
					newToolbarWithActions: allActions
					memento: self memento.

			aContainer addChild: aToolbar as: #toolbar ]
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

{ #category : #accessing }
GtMagritteElementBuilder >> implicitActions [
	^ self memento magritteActions select: #isToolbarAction
]

{ #category : #initialization }
GtMagritteElementBuilder >> initialize [

	super initialize.

	explicitActions := #(  )
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

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> objectDescription [

	^ self memento magritteDescription
]

{ #category : #'api - building' }
GtMagritteElementBuilder >> resetFrom: aButton usingModel: aModel andMemento: aMemento [
	aMemento reset
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
