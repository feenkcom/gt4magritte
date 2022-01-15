Class {
	#name : #GtMagritteValueChangedIndicatorHandler,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'indicatorElement'
	],
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> indicatorElement [

	^ indicatorElement
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> indicatorElement: anElement [

	indicatorElement := anElement.

	"Keep a reference of me, otherwise garbage collector will destroy me"
	anElement userData at: self className put: self
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> memento: anObject [

	memento := anObject
]

{ #category : #'api - announcement handling' }
GtMagritteValueChangedIndicatorHandler >> onAnnouncement: anAnnouncement [

	anAnnouncement description = self description ifFalse: [ ^ self ].

	(anAnnouncement result isSuccess and: [ 
		 anAnnouncement result isChanged ])
		ifTrue: [ self indicatorElement visibility: BlVisibility visible ]
		ifFalse: [ self indicatorElement visibility: BlVisibility hidden ]
]
