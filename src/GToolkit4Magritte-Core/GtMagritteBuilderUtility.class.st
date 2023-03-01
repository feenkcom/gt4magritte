Class {
	#name : #GtMagritteBuilderUtility,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> addCommentTooltip: anElement using: aDescription [

	| aText |
	aText := aDescription comment asRopedText.

	aDescription isRequired ifTrue: [ 
		aText append: ' (required)' asRopedText ].

	anElement addAptitude:
		(BrGlamorousWithLabelTooltipAptitude new text: aText)
]

{ #category : #'private - ui' }
GtMagritteBuilderUtility class >> addDropdownMemento: aMemento using: aDescription withContent: aContentBlock [
	| aLabel aptitude |
	aLabel := BrLabel new beFocusable.
	aLabel
		aptitude: (aDescription editorAptitude
				ifNil: [ BrGlamorousLabelAptitude new
						glamorousCodeFont;
						fontSize: 10 ]
				ifNotNil: #value).

	aptitude := aDescription editorAptitude
			ifNil: [ BrGlamorousLabelAptitude new
					glamorousCodeFont;
					fontSize: 10 ]
			ifNotNil: #value.

	aLabel
		addAptitude: (BrGlamorousWithDropdownAptitude
				handle: [ BrLabel new
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
						aptitude: aptitude;
						padding: (BlInsets all: self defaultSpaceNumber);
						withAsyncSinkDo: [ :anElementSink | 
							anElementSink
								sink: AsyncPeekSink new;
								whenUpdate: [ :theLabel :aSink | 
									| aFileModel aText |
									aFileModel := aSink value currentValue.
									aText := aDescription displayStringFor: aFileModel.
									theLabel text: aText ].
							(aMemento readObservableValueUsing: aDescription) observe: anElementSink ] ]
				content: (aContentBlock value: aLabel));
		margin: ((BlInsets left: self defaultSpaceNumber) withBottom: self defaultSpaceNumber);
		padding: (BlInsets all: self defaultSpaceNumber);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		constraintsDo: [ :c | 
			c grid horizontal alignCenter.
			c grid vertical alignCenter ];
		background: BrGlamorousColors disabledButtonBackgroundColor.

	aLabel
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theLabel :aSink | 
					| aValue aText |
					aValue := aSink value currentValue.
					aText := aDescription displayStringFor: aValue.
					theLabel text: aText ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].

	^ aLabel
]

{ #category : #'api - memento' }
GtMagritteBuilderUtility class >> createValueFrom: aModel using: aDescription [

	| aValue |
	aValue := aModel readUsing: aDescription.

	^ GtMagritteValue new
		  description: aDescription;
		  currentValue: aValue;
		  originalValue: aValue
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> defaultSpaceNumber [

	^ 4
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> defaultThickness [

	^ 3
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newBasicReadOnlyEditorWithMemento: aMemento using: aDescription [
	| anEditor aptitude |
	anEditor := BrEditor new inputFilter: BrTextEditorNoLineBreakInputFilter new.
	aptitude := aDescription editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.

	anEditor
		beReadOnlyWithSelection;
		aptitude: aptitude;
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ];
				focused: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		margin: (BlInsets bottom: self defaultSpaceNumber);
		when: BlFocusInEvent do: [ :anEvent | anEditor selecter all select ];
		when: BlFocusOutEvent do: [ :anEvent | anEditor deselecter all deselect ];
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ].
	^ anEditor
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newCancelButton [
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
			[ [ aMemento reset.
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
								cull: aMemento ] ] ] asAsyncFuture await ]
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newCheckboxMemento: aMemento using: aDescription [

	| aCheckbox |
	aCheckbox := BrCheckbox new.
	aCheckbox
		aptitude: BrGlamorousCheckboxAptitude;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theCheckbox :aSink | 
					theCheckbox checked: aSink value currentValue ].
			(aMemento readObservableValueUsing: aDescription) observe:
				anElementSink ];
		whenCheckedDo: [ aMemento write: true using: aDescription ];
		whenUncheckedDo: [ aMemento write: false using: aDescription ];
		margin: (BlInsets
				 top: 0
				 right: 0
				 bottom: self defaultSpaceNumber
				 left: 3).

	^ aCheckbox
]

{ #category : #'private - ui' }
GtMagritteBuilderUtility class >> newDirectoryDropdownContent: aDropdown memento: aMemento description: aDescription [

	| aFileBrowser |
	aFileBrowser := BrFileSelector new.
	aFileBrowser
		vExact: 250;
		hExact: 400;
		buttonLabel: 'Set';
		padding: (BlInsets all: 10);
		addAptitude: BrGlamorousWithVerticalResizerAptitude + BrGlamorousWithHorizontalResizerAptitude + BrGlamorousWithHorizontalResizerAptitude new beLeft.

	aFileBrowser okAction: [ :aFileReference | 
		aMemento write: aFileReference using: aDescription.
	
		aDropdown enqueueTask: (BlTaskAction new action: [ 
				 aDropdown dispatchEvent:
					 (BrDropdownHideWish new anchor: aDropdown) ]) ].

	aFileBrowser fileFilterBlock: [ :aFileReference | 
		aFileReference isDirectory and: [ 
			(FileSystemDirectoryEntry reference: aFileReference) isHidden not ] ].

	aFileBrowser withAsyncSinkDo: [ :anElementSink | 
		anElementSink
			sink: AsyncPeekSink new;
			whenUpdate: [ :theFileBrowser :aSink | 
				| aFileModel aFileReference |
				aFileModel := aSink value currentValue.
				aFileReference := aDescription pharoFileReferenceFor: aFileModel.
				theFileBrowser folder: aFileReference ].
		(aMemento readObservableValueUsing: aDescription) observe:
			anElementSink ].

	^ aFileBrowser
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newDirectoryDropdownMemento: aMemento using: aDescription [

	^ self
		  addDropdownMemento: aMemento
		  using: aDescription
		  withContent: [ :aLabel | 
			  [ 
			  self
				  newDirectoryDropdownContent: aLabel
				  memento: aMemento
				  description: aDescription ] ]
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newEditableLabelWithMemento: aMemento using: aDescription [
	| anEditor aptitude |
	anEditor := BrEditor new inputFilter: BrTextEditorNoLineBreakInputFilter new.
	aptitude := aDescription editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.

	anEditor
		aptitude: aptitude;
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ];
				focused: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theEditor :aSink | theEditor text: aSink value currentValue ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ];
		when: BrEditorAcceptWish
			do: [ :aWish | 
				aWish consumed: true.
				aMemento
					write: ((aDescription isKindOf: GtMATextDescription)
							ifTrue: [ aWish text copy ]
							ifFalse: [ aWish text asString ])
					using: aDescription ];
		margin: (BlInsets top: 2 bottom: self defaultSpaceNumber);
		when: BlFocusInEvent do: [ :anEvent | anEditor selecter all select ];
		when: BlFocusOutEvent do: [ :anEvent | anEditor deselecter all deselect ];
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 42 ].

	anEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			aMemento
				write: ((aDescription isKindOf: GtMATextDescription)
						ifTrue: [ anEvent text copy ]
						ifFalse: [ anEvent text asString ])
				using: aDescription ].

	^ anEditor
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newFieldLabelWithSpace: aSpaceNumber using: aDescription [
	<return: #BrLabel>
	| aText labelAptitude |
	aText := aDescription label asRopedText.
	aDescription isRequired ifTrue: [ aText append: '*' asRopedText ].
	aText append: ':' asRopedText.
	labelAptitude := aDescription labelAptitude
			ifNil: [ BrGlamorousLabelAptitude new
					foreground: BrGlamorousColors disabledButtonTextColor ]
			ifNotNil: #value.

	^ BrLabel new
		text: aText;
		aptitude: labelAptitude;
		fitContent;
		margin: (BlInsets
				top: 0
				right: (aSpaceNumber ifNil: [ self defaultSpaceNumber ])
				bottom: (aSpaceNumber ifNil: [ self defaultSpaceNumber ])
				left: 0);
		constraintsDo: [ :c | c grid vertical alignTop ]
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newFlowListMemento: aMemento using: aDescription [

	| aFlowElement |
	aFlowElement := BrFlowList new.
	aFlowElement
		matchParent;
		stencil: aDescription blocItemStencil;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theFlowElement :aSink | 
					self
						onFlowList: theFlowElement
						sinkUpdate: aSink
						memento: aMemento
						description: aDescription ].
			(aMemento readObservableValueUsing: aDescription) observe:
				anElementSink ].

	^ aFlowElement
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newHorizontalGridContainer [

	| aContainer |
	aContainer := BrHorizontalGrid new.

	aContainer magritte
		beLabelContainer;
		beFieldContainer;
		beToolbarContainer.

	aContainer
		cellSpacing: 0;
		columnCount: 2;
		fitContent.

	^ aContainer
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newIconWithMemento: aMemento using: aDescription [

	| aFrame |
	aFrame := BrFrame new.

	aFrame
		fitContent;
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c grid horizontal alignLeft ];
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :aContainer :aSink | 
					| aValue anIcon |
					aValue := aSink value currentValue.
					anIcon := aDescription blocStencil
						          model: aValue;
						          description: aDescription;
						          memento: aMemento;
						          asElement.
					aContainer
						removeChildren;
						addChild: anIcon ].

			(aMemento readObservableValueUsing: aDescription) observe:
				anElementSink ].

	^ aFrame
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newOneLineEditorWithMemento: aMemento using: aDescription [
	| anEditor aptitude |
	anEditor := BrEditor new inputFilter: BrTextEditorNoLineBreakInputFilter new.
	aptitude := aDescription editorAptitude
			ifNil: [ BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize ]
			ifNotNil: #value.

	anEditor
		aptitude: aptitude;
		addAptitude: (BrStyleCommonAptitude new
				default: [ :aStyle | aStyle border: BlBorder empty ];
				hovered: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors disabledButtonBorderColor width: 1) ];
				focused: [ :aStyle | 
					aStyle
						border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]);
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
		vFitContent;
		hFitContentLimited;
		margin: (BlInsets bottom: self defaultSpaceNumber);
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 20 ];
		when: BlFocusInEvent do: [ :anEvent | anEditor selecter all select ];
		when: BlFocusOutEvent do: [ :anEvent | anEditor deselecter all deselect ];
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theEditor :aSink | theEditor text: aSink value currentValue ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].

	anEditor editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | 
			aMemento
				write: ((aDescription isKindOf: GtMATextDescription)
						ifTrue: [ anEvent text ]
						ifFalse: [ anEvent text asString ])
				using: aDescription ].

	^ anEditor
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newReadOnlyEditorWithMemento: aMemento using: aDescription [

	| anEditor |
	anEditor := self
		            newBasicReadOnlyEditorWithMemento: aMemento
		            using: aDescription.

	anEditor withAsyncSinkDo: [ :anElementSink | 
		anElementSink
			sink: AsyncPeekSink new;
			whenUpdate: [ :theEditor :aSink | 
				theEditor text: aSink value currentValue ].
		(aMemento readObservableValueUsing: aDescription) observe:
			anElementSink ].

	^ anEditor
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newSaveButton [
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
			[ [ aMemento commit.
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
								cull: aMemento ] ] ] asAsyncFuture await ]
]

{ #category : #'private - building' }
GtMagritteBuilderUtility class >> newSingleOptionDropdownContent: aLabel memento: aMemento description: aDescription [

	^ BrSimpleList new
		  itemStencil: aDescription blocItemStencil;
		  itemDataBinder: aDescription blocItemDataBinderStencil;
		  hFitContent;
		  vFitContent;
		  padding: (BlInsets all: self defaultSpaceNumber);
		  items: aDescription options;
		  when: BrSelectionChanged do: [ :anEvent | 
			  | aWidgetElement |
			  aWidgetElement := anEvent currentTarget.

			  anEvent selectedDo: [ :anInterval | 
					  | selectedObject |
					  selectedObject := aWidgetElement viewModel itemAt:
							                    anInterval first.
					  aMemento write: selectedObject using: aDescription.
					  aLabel fireEvent: BrDropdownHideWish new ] ]
]

{ #category : #'private - building' }
GtMagritteBuilderUtility class >> newSingleOptionDropdownMemento: aMemento using: aDescription [

	^ self
		  addDropdownMemento: aMemento
		  using: aDescription
		  withContent: [ :aLabel | 
			  [ 
			  self
				  newSingleOptionDropdownContent: aLabel
				  memento: aMemento
				  description: aDescription ] ]
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newToolbarWithActions: aCollection memento: aMemento [
	| aToolbar |
	aToolbar := BrToolbar new
			aptitude: BrGlamorousToolbarAptitude new;
			fitContent;
			padding: (BlInsets top: 5 left: -3);
			constraintsDo: [ :c | 
				c grid horizontal alignLeft.
				c grid horizontal span: 2.
				c linear horizontal alignLeft ].

	aCollection
		do: [ :eachAction | 
			| aButton |
			aButton := eachAction asBlockButtonWithMemento: aMemento.
			aToolbar addItem: aButton ].

	^ aToolbar
]

{ #category : #'api - ui' }
GtMagritteBuilderUtility class >> newValidationContainerWith: aFieldElement memento: aMemento using: aDescription [
	| aContainer anIssuesElement aChangeElement anErrorElement |
	aContainer := BrHorizontalGrid new.
	aContainer
		cellSpacing: 0;
		columnCount: 4;
		hFitContentLimited;
		vFitContent.

	aChangeElement := BrFrame new.
	aChangeElement hExact: self defaultThickness.
	aChangeElement vMatchParent.
	aChangeElement background: BrGlamorousColors textHighlightColor.
	aChangeElement visibility: BlVisibility hidden.
	aChangeElement margin: (BlInsets bottom: self defaultSpaceNumber).
	aChangeElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	aChangeElement
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :aLabel :aSink | 
					| aValue |
					aValue := aSink value.
					aValue isChanged
						ifTrue: [ aLabel visibility: BlVisibility visible ]
						ifFalse: [ aLabel visibility: BlVisibility hidden ] ].
			(aMemento readObservableValueUsing: aDescription) observe: anElementSink ].

	anErrorElement := BrFrame new.
	anErrorElement hExact: self defaultThickness.
	anErrorElement vMatchParent.
	anErrorElement background: BrGlamorousColors errorBackgroundColor.
	anErrorElement visibility: BlVisibility hidden.
	anErrorElement margin: (BlInsets bottom: self defaultSpaceNumber).
	anErrorElement geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
	anErrorElement
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :aLabel :aSink | 
					| aValue |
					aValue := aSink value.
					aValue isSuccess
						ifTrue: [ aLabel visibility: BlVisibility hidden ]
						ifFalse: [ aLabel visibility: BlVisibility visible ] ].
			(aMemento validatorUsing: aDescription) observe: anElementSink ].

	anIssuesElement := BrEditor new.
	anIssuesElement
		aptitude: (BrGlamorousRegularEditorAptitude new
				glamorousRegularFont;
				glamorousCodeSmallSize;
				foreground: BrGlamorousColors errorBackgroundColor);
		beReadOnlyWithSelection;
		beNotFocusable;
		hFitContentLimited;
		vFitContent;
		text: '';
		padding: (BlInsets
				top: -4
				left: 5
				bottom: 5
				right: 0);
		visibility: BlVisibility gone;
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :aLabel :aSink | 
					| aValue |
					aValue := aSink value.
					(aValue value isChanged not or: [ aValue isSuccess ])
						ifTrue: [ aLabel
								text: '';
								visibility: BlVisibility hidden ]
						ifFalse: [ aLabel
								text: aValue issuesDescription;
								visibility: BlVisibility visible ] ].
			(aMemento validatorUsing: aDescription) observe: anElementSink ].

	aContainer addChild: aChangeElement as: #changeIndicator.
	aContainer addChild: aFieldElement as: #field.
	aContainer addChild: anErrorElement as: #errorIndicator.
	aContainer addChild: anIssuesElement as: #issues.

	^ aContainer
]

{ #category : #'private - support' }
GtMagritteBuilderUtility class >> onFlowList: aFlowElement sinkUpdate: aSink memento: aMemento description: aDescription [
	| aModels anExistingViewModels isEditable aViewModels |
	aModels := aSink value currentValue ifNil: [ #() ].
	anExistingViewModels := aFlowElement items.
	isEditable := aDescription definitive not
			and: [ aDescription newItemStencil isNotNil ].

	aViewModels := Array
			new: aModels size + isEditable asBit
			streamContents: [ :aStream | 
				self
					recycleViewModels: anExistingViewModels
					forModels: aModels
					into: aStream
					memento: aMemento
					description: aDescription.

				isEditable
					ifTrue: [ | anAddViewModel |
						anAddViewModel := GtMagritteAddItemViewModel new
								memento: aMemento;
								description: aDescription;
								stencil: aDescription newItemStencil.
						aStream nextPut: anAddViewModel ] ].


	^ aFlowElement items: aViewModels
]

{ #category : #'private - support' }
GtMagritteBuilderUtility class >> recycleViewModels: anExistingViewModels forModels: aModels into: aStream memento: aMemento description: aDescription [
	aModels
		do: [ :aModel | 
			anExistingViewModels
				detect: [ :eachViewModel | eachViewModel isForObject: aModel ]
				ifFound: [ :aViewModel | aStream nextPut: aViewModel ]
				ifNone: [ | aViewModel |
					aViewModel := aDescription blocItemViewModelStencil
							model: aModel;
							description: aDescription;
							build.
					aDescription definitive
						ifFalse: [ aViewModel
								addButton: (GtMagritteButtonWithIconAction new
										icon: BrGlamorousVectorIcons remove;
										tooltip: 'Remove';
										action: [ :anItemModel :aButton :anItemMemento | 
											[ self
												removeItem: aModel
												memento: aMemento
												description: aDescription ] asAsyncFuture await ]) ].

					aStream nextPut: aViewModel ] ]
]

{ #category : #'private - support' }
GtMagritteBuilderUtility class >> removeItem: anItem memento: aMemento description: aDescription [

	| aNewCollection anObservable aValue |
	anObservable := aMemento readObservableValueUsing: aDescription.
	aValue := anObservable valueOrNil.
	aNewCollection := aValue currentValue copyWithout: anItem.
	aNewCollection = aValue currentValue ifFalse: [ 
		anObservable value: (aValue copyWithCurrentValue: aNewCollection) ]
]
