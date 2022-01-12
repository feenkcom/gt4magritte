Trait {
	#name : #TGtMagritteWithMemento,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #'api - memento' }
TGtMagritteWithMemento >> hasMemento [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<objectTester: #memento>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ memento notNil
]

{ #category : #'api - memento' }
TGtMagritteWithMemento >> memento [
	"Return a not-null memento assigned to the receiver"
	<objectGetter: #memento>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ memento notNil ]
		description: [ 'memento should be initialized' ].

	^ memento
]

{ #category : #'api - memento' }
TGtMagritteWithMemento >> memento: aMemento [
	"Set a not-null memento assigned to the receiver"
	<objectSetter: #memento>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aMemento notNil ]
		description: [ 'memento must not be nil' ].

	memento == aMemento
		ifTrue: [ ^ self ].

	memento ifNotNil: [ self unsubscribeFromMemento ].
	memento := aMemento.

	self onMementoChanged.
	self subscribeToMemento.
	self onPostMementoChanged
]

{ #category : #'api - memento' }
TGtMagritteWithMemento >> onMementoChanged [
	"Is sent when a new memento is assigned to the receiver.
	Note: #onMementoChanged is sent before #subscribeToMemento
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostMementoChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - memento' }
TGtMagritteWithMemento >> onPostMementoChanged [
	"I am an optional hook method that is sent after #subscribeToMemento.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - memento' }
TGtMagritteWithMemento >> subscribeToMemento [
	"Is sent after a new memento is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromMemento if the receiver subscribes to them"
	<objectSubscriber: #memento>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - memento' }
TGtMagritteWithMemento >> unsubscribeFromMemento [
	"Is sent before a new memento is assigned to the receiver.
	Objects that subscribe to memento are required to implement this method."
	<objectUnsubscriber: #memento>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
