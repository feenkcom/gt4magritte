Class {
	#name : #GtMagritteValueChangedEditableEditorHandler,
	#superclass : #GtMagritteElementHandler,
	#instVars : [
		'description'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Support'
}

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> editorElement [

	^ self element
]

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> editorElement: anElement [

	self element: anElement.
]

{ #category : #'api - announcement handling' }
GtMagritteValueChangedEditableEditorHandler >> onAnnouncement: anAnnouncement [

	anAnnouncement description = self description ifFalse: [ ^ self ].
	anAnnouncement result isSuccess ifFalse: [ ^ self ].

	self enqueueAction: [ 
		self editorElement text: anAnnouncement result value ]
]
