Class {
	#name : #GtMagritteElementHandler,
	#superclass : #Object,
	#instVars : [
		'element',
		'memento'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Support'
}

{ #category : #accessing }
GtMagritteElementHandler >> element [

	^ element
]

{ #category : #accessing }
GtMagritteElementHandler >> element: anElement [

	self
		assert: [ element isNil ]
		description: [ 'Element can be initialized only once' ].

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
