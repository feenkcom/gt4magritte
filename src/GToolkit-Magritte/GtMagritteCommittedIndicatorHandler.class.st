Class {
	#name : #GtMagritteCommittedIndicatorHandler,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'indicatorElement'
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

	^ indicatorElement
]

{ #category : #accessing }
GtMagritteCommittedIndicatorHandler >> indicatorElement: anElement [

	indicatorElement := anElement.
	
	"Keep a reference of me, otherwise garbage collector will destroy me"
	anElement userData at: self className put: self
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

	self indicatorElement visibility: BlVisibility hidden
]
