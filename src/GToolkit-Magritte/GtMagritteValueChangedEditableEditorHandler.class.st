Class {
	#name : #GtMagritteValueChangedEditableEditorHandler,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'editorElement'
	],
	#category : #'GToolkit-Magritte-Utilities'
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

	^ editorElement
]

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> editorElement: anElement [

	editorElement := anElement.

	"Keep a reference of me, otherwise garbage collector will destroy me"
	anElement userData at: self className put: self
]

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteValueChangedEditableEditorHandler >> memento: anObject [

	memento := anObject
]

{ #category : #'api - announcement handling' }
GtMagritteValueChangedEditableEditorHandler >> onAnnouncement: anAnnouncement [

	anAnnouncement description = self description ifFalse: [ ^ self ].
	anAnnouncement result isSuccess ifFalse: [ ^ self ].

	self editorElement enqueueTask: (BlTaskAction new action: [ 
			 self editorElement text: anAnnouncement result value ])
]
