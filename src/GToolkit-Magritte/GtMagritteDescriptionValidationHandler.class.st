Class {
	#name : #GtMagritteDescriptionValidationHandler,
	#superclass : #GtMagritteElementHandler,
	#instVars : [
		'description'
	],
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> editorElement [

	^ self element
]

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> editorElement: anElement [

	self element: anElement
]

{ #category : #'announcement handling' }
GtMagritteDescriptionValidationHandler >> handleResult: aResult [

	aResult isSuccess
		ifTrue: [ 
			self enqueueAction: [ 
				self editorElement visibility: BlVisibility gone.
				self editorElement text: '' ] ]
		ifFalse: [ 
			| aText |
			aText := aResult issuesDescription.
			self enqueueAction: [ 
				self editorElement visibility: BlVisibility visible.
				self editorElement text: aText ] ]
]

{ #category : #'announcement handling' }
GtMagritteDescriptionValidationHandler >> onAnnouncement: anAnnouncement [

	anAnnouncement memento = self memento ifFalse: [ ^ self ].
	anAnnouncement description = self description ifFalse: [ ^ self ].

	self handleResult: anAnnouncement result
]

{ #category : #'api - actions' }
GtMagritteDescriptionValidationHandler >> update [

	self enqueueAction: [ 
		(self memento validationPromiseUsing: self description) then: [ 
			:aResult | self handleResult: aResult ] ]
]
