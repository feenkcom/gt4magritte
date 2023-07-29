Class {
	#name : #GtMagritteBooleanElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtMagritteWithFieldViewModel',
	#classTraits : 'TGtMagritteWithFieldViewModel classTrait',
	#instVars : [
		'labelElement',
		'checkboxElement'
	],
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #initialization }
GtMagritteBooleanElement >> initialize [
	super initialize.

	self initializeCheckboxElement.
	self initializeLabelElement.

	self addChild: checkboxElement as: #checkbox.
	self addChild: labelElement as: #label.

	self withAsyncSinkDo: [ :anElementSink | 
		anElementSink
			sink: AsyncPeekSink new;
			whenUpdate: [ :anElement :aSink | 
				self onMagritteValueChanged: aSink value ] ].
	
	self
		hFitContentLimited;
		vFitContent.
]

{ #category : #initialization }
GtMagritteBooleanElement >> initializeCheckboxElement [
	checkboxElement := BrCheckbox new.
	checkboxElement
		fitContent;
		aptitude: BrGlamorousCheckboxAptitude;
		margin: (BlInsets
				top: 0
				right: 0
				bottom: GtMagritteBuilderUtility defaultSpaceNumber
				left: 3).

	checkboxElement
		whenCheckedDo: [ self writeCheckedMemento ];
		whenUncheckedDo: [ self writeUncheckedMemento ].

	checkboxElement constraintsDo: [ :c | 
		c linear vertical alignCenter ]
]

{ #category : #initialization }
GtMagritteBooleanElement >> initializeLabelElement [
	labelElement := BrEditor new
		beReadOnlyWithSelection;
		aptitude: BrGlamorousRegularEditorAptitude new glamorousRegularFontAndSize.
		
	GtMagritteBuilderUtility styleEditorWidget: labelElement.
				
	labelElement constraintsDo: [ :c | 
		c linear vertical alignCenter ].
		
	labelElement margin: labelElement margin 
		+ (BlInsets left: GtMagritteBuilderUtility defaultSpaceNumber)
]

{ #category : #'private - event handling' }
GtMagritteBooleanElement >> onDescriptionPropertyChanged: anAnnouncement [
	(anAnnouncement key = #trueString or: [ anAnnouncement key = #falseString ])
		ifTrue: [ self updateLabelElement ]
]

{ #category : #'api - field view model' }
GtMagritteBooleanElement >> onFieldViewModelChanged [
	"Is sent when a new fieldViewModel is assigned to the receiver.
	Note: #onFieldViewModelChanged is sent before #subscribeToFieldViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostFieldViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	
	self inUIProcessDo: [
		self updateBooleanElement ]
]

{ #category : #'private - event handling' }
GtMagritteBooleanElement >> onMagritteValueChanged: aGtMagritteValue [
	self updateCheckbox: aGtMagritteValue.
	self updateLabel: aGtMagritteValue
]

{ #category : #'api - field view model' }
GtMagritteBooleanElement >> onPostFieldViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToFieldViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	
	self withAsyncSinkDo: [ :anElementSink | 
		self observableValue observe: anElementSink ]
]

{ #category : #'api - field view model' }
GtMagritteBooleanElement >> subscribeToFieldViewModel [
	"Is sent after a new fieldViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromFieldViewModel if the receiver subscribes to them"
	
	self fieldViewModel description 
		whenPropertyChangedSend: #onDescriptionPropertyChanged: 
		to: self
]

{ #category : #'api - field view model' }
GtMagritteBooleanElement >> unsubscribeFromFieldViewModel [
	"Is sent before a new fieldViewModel is assigned to the receiver.
	Objects that subscribe to fieldViewModel are required to implement this method."
	
	self fieldViewModel description unsubscribe: self
]

{ #category : #'private - updating' }
GtMagritteBooleanElement >> updateBooleanElement [
	self updateCheckboxElement.
	self updateLabelElement.
]

{ #category : #'private - updating' }
GtMagritteBooleanElement >> updateCheckbox: aGtMagritteValue [
	checkboxElement checked: (aGtMagritteValue currentValue ifNil: [ false ])
]

{ #category : #'private - updating' }
GtMagritteBooleanElement >> updateCheckboxElement [
	self observableValue
		ifSome: [ :aValue | self updateCheckbox: aValue ]
		ifNone: [ checkboxElement checked: false ]
]

{ #category : #'private - updating' }
GtMagritteBooleanElement >> updateLabel: aGtMagritteValue [
	| aLabel |
	aLabel := self description labelForOption: aGtMagritteValue currentValue.

	labelElement text: aLabel
]

{ #category : #'private - updating' }
GtMagritteBooleanElement >> updateLabelElement [
	self description hasCustomLabels
		ifTrue: [ 
			labelElement visibility: BlVisibility visible ]
		ifFalse: [ 
			labelElement visibility: BlVisibility gone.
			^ self ].

	self observableValue
		ifSome: [ :aValue |
			self updateLabel: aValue ] 
		ifNone: [
			labelElement text: '' ]
]

{ #category : #'private - event handling' }
GtMagritteBooleanElement >> writeCheckedMemento [
	self hasFieldViewModel ifFalse: [ ^ self ].
	
	GtMagritteBuilderUtility 
		write: true 
		using: self description 
		memento: self memento 
		element: self
]

{ #category : #'private - event handling' }
GtMagritteBooleanElement >> writeUncheckedMemento [
	self hasFieldViewModel ifFalse: [ ^ self ].
	
	GtMagritteBuilderUtility 
		write: false 
		using: self description 
		memento: self memento 
		element: self
]
