Trait {
	#name : #TGtMagritteWithStatusModel,
	#instVars : [
		'statusModel'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> hasStatusModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #statusModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ statusModel notNil
]

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> onPostStatusModelChanged [
	"I am an optional hook method that is sent after #subscribeToStatusModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> onStatusModelChanged [
	"Is sent when a new statusModel is assigned to the receiver.
	Note: #onStatusModelChanged is sent before #subscribeToStatusModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostStatusModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> statusModel [
	"Return a not-null statusModel assigned to the receiver"
	<objectGetter: #statusModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ statusModel notNil ]
		description: [ 'statusModel should be initialized' ].

	^ statusModel
]

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> statusModel: aStatusModel [
	"Set a not-null statusModel assigned to the receiver"
	<objectSetter: #statusModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aStatusModel notNil ]
		description: [ 'statusModel must not be nil' ].

	statusModel == aStatusModel
		ifTrue: [ ^ self ].

	statusModel ifNotNil: [ self unsubscribeFromStatusModel ].
	statusModel := aStatusModel.

	self onStatusModelChanged.
	self subscribeToStatusModel.
	self onPostStatusModelChanged
]

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> subscribeToStatusModel [
	"Is sent after a new statusModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromStatusModel if the receiver subscribes to them"
	<objectSubscriber: #statusModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - status model' }
TGtMagritteWithStatusModel >> unsubscribeFromStatusModel [
	"Is sent before a new statusModel is assigned to the receiver.
	Objects that subscribe to statusModel are required to implement this method."
	<objectUnsubscriber: #statusModel>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
