Class {
	#name : #GtMagritteValueChangedIndicatorHandler,
	#superclass : #GtMagritteElementHandler,
	#instVars : [
		'description'
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

{ #category : #'api - announcement handling' }
GtMagritteValueChangedIndicatorHandler >> handleResult: aResult [

	self enqueueAction: [ 
		(aResult isSuccess and: [ aResult isChanged ])
			ifTrue: [ self indicatorElement visibility: BlVisibility visible ]
			ifFalse: [ self indicatorElement visibility: BlVisibility hidden ] ]
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> indicatorElement [

	^ self element
]

{ #category : #accessing }
GtMagritteValueChangedIndicatorHandler >> indicatorElement: anElement [

	self element: anElement
]

{ #category : #'api - announcement handling' }
GtMagritteValueChangedIndicatorHandler >> onAnnouncement: anAnnouncement [

	| aResult |
	anAnnouncement description = self description ifFalse: [ ^ self ].

	aResult := anAnnouncement result.
	self handleResult: aResult
]

{ #category : #'api - actions' }
GtMagritteValueChangedIndicatorHandler >> update [

	self enqueueAction: [ 
		(self memento readPromiseUsing: self description) then: [ :aResult | 
			self handleResult: aResult ] ]
]
