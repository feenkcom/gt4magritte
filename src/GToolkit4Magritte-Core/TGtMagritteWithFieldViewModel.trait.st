Trait {
	#name : #TGtMagritteWithFieldViewModel,
	#instVars : [
		'fieldViewModel'
	],
	#category : #'GToolkit4Magritte-Core-View Models'
}

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> description [
	^ self fieldViewModel description
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> fieldViewModel [
	"Return a not-null fieldViewModel assigned to the receiver"
	<objectGetter: #fieldViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ fieldViewModel notNil ]
		description: [ 'fieldViewModel should be initialized' ].

	^ fieldViewModel
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> fieldViewModel: aFieldViewModel [
	"Set a not-null fieldViewModel assigned to the receiver"
	<objectSetter: #fieldViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aFieldViewModel notNil ]
		description: [ 'fieldViewModel must not be nil' ].

	fieldViewModel == aFieldViewModel
		ifTrue: [ ^ self ].

	fieldViewModel ifNotNil: [ self unsubscribeFromFieldViewModel ].
	fieldViewModel := aFieldViewModel.

	self onFieldViewModelChanged.
	self subscribeToFieldViewModel.
	self onPostFieldViewModelChanged
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> hasFieldViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #fieldViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ fieldViewModel notNil
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> memento [
	^ self fieldViewModel memento
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> observableValue [
	<return: #AsyncObservableValue of: #GtMagritteValue>
	^ self memento readObservableValueUsing: self description
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> onFieldViewModelChanged [
	"Is sent when a new fieldViewModel is assigned to the receiver.
	Note: #onFieldViewModelChanged is sent before #subscribeToFieldViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostFieldViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> onPostFieldViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToFieldViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> subscribeToFieldViewModel [
	"Is sent after a new fieldViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromFieldViewModel if the receiver subscribes to them"
	<objectSubscriber: #fieldViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - field view model' }
TGtMagritteWithFieldViewModel >> unsubscribeFromFieldViewModel [
	"Is sent before a new fieldViewModel is assigned to the receiver.
	Objects that subscribe to fieldViewModel are required to implement this method."
	<objectUnsubscriber: #fieldViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
