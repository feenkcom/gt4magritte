Trait {
	#name : #TGtMagritteWithMementoViewModel,
	#instVars : [
		'mementoViewModel'
	],
	#category : #'GToolkit4Magritte-Core-View Models'
}

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> hasMementoViewModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #mementoViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ mementoViewModel notNil
]

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> mementoViewModel [
	"Return a not-null mementoViewModel assigned to the receiver"
	<objectGetter: #mementoViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ mementoViewModel notNil ]
		description: [ 'mementoViewModel should be initialized' ].

	^ mementoViewModel
]

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> mementoViewModel: aMementoViewModel [
	"Set a not-null mementoViewModel assigned to the receiver"
	<objectSetter: #mementoViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aMementoViewModel notNil ]
		description: [ 'mementoViewModel must not be nil' ].

	mementoViewModel == aMementoViewModel
		ifTrue: [ ^ self ].

	mementoViewModel ifNotNil: [ self unsubscribeFromMementoViewModel ].
	mementoViewModel := aMementoViewModel.

	self onMementoViewModelChanged.
	self subscribeToMementoViewModel.
	self onPostMementoViewModelChanged
]

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> onMementoViewModelChanged [
	"Is sent when a new mementoViewModel is assigned to the receiver.
	Note: #onMementoViewModelChanged is sent before #subscribeToMementoViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostMementoViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> onPostMementoViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToMementoViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> subscribeToMementoViewModel [
	"Is sent after a new mementoViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromMementoViewModel if the receiver subscribes to them"
	<objectSubscriber: #mementoViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - memento view model' }
TGtMagritteWithMementoViewModel >> unsubscribeFromMementoViewModel [
	"Is sent before a new mementoViewModel is assigned to the receiver.
	Objects that subscribe to mementoViewModel are required to implement this method."
	<objectUnsubscriber: #mementoViewModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
