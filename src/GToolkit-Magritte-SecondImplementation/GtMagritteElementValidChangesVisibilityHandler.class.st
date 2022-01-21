Class {
	#name : #GtMagritteElementValidChangesVisibilityHandler,
	#superclass : #GtMagritteElementHandler,
	#category : #'GToolkit-Magritte-SecondImplementation-Support'
}

{ #category : #'api - announcement handling' }
GtMagritteElementValidChangesVisibilityHandler >> handleResult: aResult [

	self enqueueAction: [ 
		((aResult isSuccess and: [ aResult isChanged ]) or: [ 
			 aResult isSuccess not ])
			ifTrue: [ self element visibility: BlVisibility visible ]
			ifFalse: [ self element visibility: BlVisibility hidden ] ]
]

{ #category : #'api - announcement handling' }
GtMagritteElementValidChangesVisibilityHandler >> onAnnouncement: anAnnouncement [

	anAnnouncement memento = self memento ifFalse: [ ^ self ].

	self handleResult: anAnnouncement result
]

{ #category : #accessing }
GtMagritteElementValidChangesVisibilityHandler >> update [

	"self enqueueAction: [ 
		self memento validationPromise then: [ :aResult | 
			self handleResult: aResult ] ]"
]
