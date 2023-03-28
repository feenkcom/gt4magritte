Class {
	#name : #GtMagritteCallbackError,
	#superclass : #Object,
	#instVars : [
		'callback',
		'exception'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #accessing }
GtMagritteCallbackError >> callback [
	^ callback
]

{ #category : #accessing }
GtMagritteCallbackError >> callback: anObject [
	callback := anObject
]

{ #category : #accessing }
GtMagritteCallbackError >> exception [
	^ exception
]

{ #category : #accessing }
GtMagritteCallbackError >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
GtMagritteCallbackError >> messageText [
	^ self exception
		ifNotNil: [ :anException | 
			anException messageText ifEmpty: [ anException printString ] ]
		ifNil: [ 'Unknown error' ]
]
