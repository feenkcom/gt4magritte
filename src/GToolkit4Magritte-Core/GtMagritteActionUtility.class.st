Class {
	#name : #GtMagritteActionUtility,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #execution }
GtMagritteActionUtility class >> freeze: anException [
	| anExceptionCopy |
	anExceptionCopy := anException copy.

	anExceptionCopy signalContext ifNotNil: [ anExceptionCopy freeze ].
	^ anExceptionCopy
]
