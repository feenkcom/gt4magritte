Class {
	#name : #GtMagritteDescriptionValidationHandler,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'editorElement'
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

	^ editorElement
]

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> editorElement: anElement [

	self
		assert: [ editorElement isNil ]
		description: [ 'Editor element can be initialized only once' ].

	editorElement := anElement.

	"Keep a reference of me, otherwise garbage collector will destroy me"
	anElement userData at: self class name put: self
]

{ #category : #private }
GtMagritteDescriptionValidationHandler >> enqueueAction: aBlock [

	self editorElement enqueueTask: (BlTaskAction new action: aBlock)
]

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteDescriptionValidationHandler >> memento: anObject [

	memento := anObject
]

{ #category : #'announcement handling' }
GtMagritteDescriptionValidationHandler >> onAnnouncement: anAnnouncement [

	| aResult |
	anAnnouncement memento = self memento ifFalse: [ ^ self ].
	anAnnouncement description = self description ifFalse: [ ^ self ].
	
	aResult := anAnnouncement result.

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
