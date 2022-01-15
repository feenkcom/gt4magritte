Class {
	#name : #GtMagritteCommittedIndicatorHandler,
	#superclass : #GtMagritteElementHandler,
	#instVars : [
		'description'
	],
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> indicatorElement [

	^ self element
]

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> indicatorElement: anElement [

	self element: anElement
]

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> memento: anObject [

	memento := anObject
]

{ #category : #'api - announcement handling' }
GtMagritteCommittedIndicatorHandler >> onAnnouncement: anAnnouncement [

	anAnnouncement result isSuccess ifFalse: [ ^ self ].

	self enqueueAction: [ 
		self indicatorElement visibility: BlVisibility hidden ]
]
