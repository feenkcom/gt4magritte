Class {
	#name : #GtMagritteActionElement,
	#superclass : #BrButton,
	#traits : 'TGtMagritteWithFieldViewModel',
	#classTraits : 'TGtMagritteWithFieldViewModel classTrait',
	#instVars : [
		'currentAptitude'
	],
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #initialization }
GtMagritteActionElement >> initialize [
	super initialize.

	self beFocusable.
	self beTinySize.

	self
		withAsyncSinkDo: [ :anElementSink | 
			anElementSink
				sink: AsyncPeekSink new;
				whenUpdate: [ :theButton :aSink | 
					self onOverallStatusChanged: aSink value ] ].
]

{ #category : #'private - announcement handling' }
GtMagritteActionElement >> onDescriptionPropertyChanged: anAnnouncement [
	anAnnouncement key = #action
		ifTrue: [ self inUIProcessDo: [ self updateAction ] ].
	anAnnouncement key = #label
		ifTrue: [ self inUIProcessDo: [ self updateLabel ] ].
	anAnnouncement key = #blocIcon
		ifTrue: [ self inUIProcessDo: [ self updateIcon ] ].
	anAnnouncement key = #action
		ifTrue: [ self inUIProcessDo: [ self updateAction ] ].
	anAnnouncement key = #isLabelVisible
		ifTrue: [ self inUIProcessDo: [ self updateAptitude ] ].
	anAnnouncement key = #enabled
		ifTrue: [ self enqueueTask: (BlTaskAction new action: [ self updateEnabled ]) ].
	anAnnouncement key = #visible
		ifTrue: [ self inUIProcessDo: [ self updateVisibility ] ]
]

{ #category : #'api - field view model' }
GtMagritteActionElement >> onFieldViewModelChanged [
	"Is sent when a new fieldViewModel is assigned to the receiver.
	Note: #onFieldViewModelChanged is sent before #subscribeToFieldViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostFieldViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self enqueueTask: (BlTaskAction new action: [ self updateActionElement ])
]

{ #category : #'private - event handling' }
GtMagritteActionElement >> onOverallStatusChanged: anOveralStatus [
	self description onOverallStatusChanged
		ifNotNil: [ :aBlock | 
			aBlock
				cull: anOveralStatus
				cull: self
				cull: self memento
				cull: self description ]
]

{ #category : #'api - field view model' }
GtMagritteActionElement >> onPostFieldViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToFieldViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."

	self
		withAsyncSinkDo: [ :anElementSink | 
			self memento overallStatus observe: anElementSink ]
]

{ #category : #'private - updating' }
GtMagritteActionElement >> replaceAptitudeWith: anAptitude [
	| anInstance |
	anInstance := anAptitude asLook.

	currentAptitude ifNotNil: [ :aCurrentAptitude | 
		self removeAptitude: aCurrentAptitude.
		currentAptitude := nil ].

	self addAptitude: anInstance.
	currentAptitude := anInstance
]

{ #category : #'api - field view model' }
GtMagritteActionElement >> subscribeToFieldViewModel [
	"Is sent after a new fieldViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromFieldViewModel if the receiver subscribes to them"

	self description
		whenPropertyChangedSend: #onDescriptionPropertyChanged:
		to: self
]

{ #category : #'api - field view model' }
GtMagritteActionElement >> unsubscribeFromFieldViewModel [
	"Is sent before a new fieldViewModel is assigned to the receiver.
	Objects that subscribe to fieldViewModel are required to implement this method."

	self description unsubscribe: self
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateAction [
	self description action ifNotNil: [ :anAction | 
		self
			action: [ :theButton | 
				anAction
					cull: self memento model
					cull: theButton
					cull: self memento
					cull: self description ] ]
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateActionElement [
	self updateElementId.
	self updateAction.
	self updateIcon.
	self updateLabel.
	self updateAptitude.
	self updateEnabled.
	self updateVisibility.
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateAptitude [
	self description isLabelVisible
		ifTrue: [ self replaceAptitudeWith: BrGlamorousButtonWithIconAndLabelAptitude ]
		ifFalse: [ self replaceAptitudeWith: BrGlamorousButtonWithIconAptitude ]
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateElementId [
	self id: (GtMagritteActionElementId new description: self description)
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateEnabled [
	self description enabled ifNotNil: [ :aBoolean | 
		self enabled: aBoolean ]
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateIcon [
	self description blocIcon ifNotNil: [ :aStencil | 
		self icon: aStencil ]
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateLabel [
	self description label ifNotNil: [ :aLabel | 
		self label: aLabel ]
]

{ #category : #'private - updating' }
GtMagritteActionElement >> updateVisibility [
	self description visible
		ifNotNil: [ :aBoolean | 
			aBoolean
				ifTrue: [ self visibility: BlVisibility visible ]
				ifFalse: [ self visibility: BlVisibility gone ] ]
]
