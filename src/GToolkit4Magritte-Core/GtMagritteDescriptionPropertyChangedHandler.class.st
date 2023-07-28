Class {
	#name : #GtMagritteDescriptionPropertyChangedHandler,
	#superclass : #Object,
	#instVars : [
		'key',
		'receiver',
		'selector'
	],
	#category : #'GToolkit4Magritte-Core-Description Properties'
}

{ #category : #accessing }
GtMagritteDescriptionPropertyChangedHandler >> key [
	^ key
]

{ #category : #accessing }
GtMagritteDescriptionPropertyChangedHandler >> key: aSelector [
	"Set a description property name, reacting to its changes."

	key := aSelector
]

{ #category : #'announcement handling' }
GtMagritteDescriptionPropertyChangedHandler >> onAnnouncement: anAnnouncement [
	| aValue |
	key = anAnnouncement key ifFalse: [ ^ self ].

	aValue := anAnnouncement owner perform: key.
	aValue ifNil: [ ^ self ].

	receiver perform: selector with: aValue
]

{ #category : #accessing }
GtMagritteDescriptionPropertyChangedHandler >> receiver [
	^ receiver
]

{ #category : #accessing }
GtMagritteDescriptionPropertyChangedHandler >> receiver: anObject [
	"An object (e.g., a Block widget) which should be notified about a description property change."

	receiver := anObject
]

{ #category : #accessing }
GtMagritteDescriptionPropertyChangedHandler >> selector [
	^ selector
]

{ #category : #accessing }
GtMagritteDescriptionPropertyChangedHandler >> selector: aSelector [
	"A method that should be used to inform about receivers about description property changes.
	The selector should have one argument which is the new description property value."

	selector := aSelector
]

{ #category : #'api - subscriptions' }
GtMagritteDescriptionPropertyChangedHandler >> subscribeToDescription: aDescription [
	"Subscribe the handler to the description propery changes."

	aDescription whenPropertyChangedSend: #onAnnouncement: to: self
]
