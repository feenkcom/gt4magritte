Class {
	#name : #GtMagritteOneLineEditorElement,
	#superclass : #BrEditor,
	#traits : 'TGtMagritteWithFieldViewModel',
	#classTraits : 'TGtMagritteWithFieldViewModel classTrait',
	#instVars : [
		'editorAptitude',
		'editorEventHandler'
	],
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #initialization }
GtMagritteOneLineEditorElement >> initialize [
	super initialize.

	self
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
		margin: (BlInsets top: 2 bottom: GtMagritteBuilderUtility defaultSpaceNumber);
		constraintsDo: [ :c | 
			c grid vertical alignCenter.
			c minWidth: 42 ];
		when: BlFocusInEvent do: [ :anEvent | self selecter all select ];
		when: BlFocusOutEvent do: [ :anEvent | self deselecter all deselect ].

	self inputFilter: BrTextEditorNoLineBreakInputFilter new.

	self
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theEditor :aSink | 
					self updateEditorText: aSink value ] ]
]

{ #category : #'private - announcement handling' }
GtMagritteOneLineEditorElement >> onDescriptionChanged: anAnnouncement [
	self onDescriptionPropertyChanged: anAnnouncement
]

{ #category : #'private - announcement handling' }
GtMagritteOneLineEditorElement >> onDescriptionPropertyChanged: anAnnouncement [
	anAnnouncement key = #readOnly 
		ifTrue: [ self updateEditorMode ]
]

{ #category : #'api - field view model' }
GtMagritteOneLineEditorElement >> onFieldViewModelChanged [
	"Is sent when a new fieldViewModel is assigned to the receiver.
	Note: #onFieldViewModelChanged is sent before #subscribeToFieldViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostFieldViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self inUIProcessDo: [ 
		self updateEditorAptitude.
		self updateEditorMode. ]
]

{ #category : #'api - field view model' }
GtMagritteOneLineEditorElement >> onPostFieldViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToFieldViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."

	self withAsyncSinkDo: [ :anElementSink | 
		self observableValue observe: anElementSink ]
]

{ #category : #'api - field view model' }
GtMagritteOneLineEditorElement >> subscribeToFieldViewModel [
	"Is sent after a new fieldViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromFieldViewModel if the receiver subscribes to them"
	
	self fieldViewModel description 
		whenPropertyChangedSend: #onDescriptionPropertyChanged: 
		to: self
]

{ #category : #'api - field view model' }
GtMagritteOneLineEditorElement >> unsubscribeFromFieldViewModel [
	"Is sent before a new fieldViewModel is assigned to the receiver.
	Objects that subscribe to fieldViewModel are required to implement this method."
	
	self fieldViewModel description unsubscribe: self
]

{ #category : #'private - updating' }
GtMagritteOneLineEditorElement >> updateAsEditable [
	self beEditable.

	editorEventHandler ifNil: [ 
		editorEventHandler := BlEventHandler 
			on: BrTextEditorModifiedEvent 
			do: [ :anEvent | 
				GtMagritteBuilderUtility
					writeText: anEvent text
					using: self description
					memento: self memento
					element: self ].
		
		self editor addEventHandler: editorEventHandler.
		^ self ].

	(self editor hasEventHandler: editorEventHandler) ifFalse: [ 
		self editor addEventHandler: editorEventHandler ].
]

{ #category : #'private - updating' }
GtMagritteOneLineEditorElement >> updateAsReadyOnly [
	self beReadOnlyWithSelection.
	
	editorEventHandler ifNil: [ ^ self ].

	(self editor hasEventHandler: editorEventHandler)
		ifTrue: [ self editor removeEventHandler: editorEventHandler ]
]

{ #category : #'private - updating' }
GtMagritteOneLineEditorElement >> updateEditorAptitude [
	| newAptitude |
	editorAptitude ifNotNil: [ :anAptitude | 
		editorAptitude := nil.
		self removeAptitude: anAptitude ].

	editorAptitude := newAptitude := self description editorAptitude
		ifNil: [ BrGlamorousRegularEditorAptitude new 
					glamorousRegularFontAndSize ]
		ifNotNil: #value.

	self addAptitude: newAptitude
]

{ #category : #'private - updating' }
GtMagritteOneLineEditorElement >> updateEditorMode [
	self description isReadOnly
		ifTrue: [ self updateAsReadyOnly ]
		ifFalse: [ self updateAsEditable ]
]

{ #category : #'private - updating' }
GtMagritteOneLineEditorElement >> updateEditorText: aGtMagritteValue [
	self text: aGtMagritteValue currentValue
]
