Class {
	#name : #GtMagritteElementHandler,
	#superclass : #Object,
	#instVars : [
		'element',
		'memento'
	],
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #accessing }
GtMagritteElementHandler >> element [

	^ element
]

{ #category : #accessing }
GtMagritteElementHandler >> element: anElement [

	element := anElement.

	"Keep a reference of me, otherwise garbage collector will destroy me"
	anElement userData at: self className put: self
]

{ #category : #private }
GtMagritteElementHandler >> enqueueAction: aBlock [

	self element enqueueTask: (BlTaskAction new action: aBlock)
]

{ #category : #accessing }
GtMagritteElementHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteElementHandler >> memento: anObject [

	memento := anObject
]
