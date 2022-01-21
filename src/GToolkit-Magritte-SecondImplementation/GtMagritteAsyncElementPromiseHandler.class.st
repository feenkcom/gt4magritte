Class {
	#name : #GtMagritteAsyncElementPromiseHandler,
	#superclass : #GtMagritteElementHandler,
	#instVars : [
		'description'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Support'
}

{ #category : #accessing }
GtMagritteAsyncElementPromiseHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteAsyncElementPromiseHandler >> description: anObject [

	description := anObject
]

{ #category : #'api - announcement handling' }
GtMagritteAsyncElementPromiseHandler >> handleResult: aResult [

	self element asyncPromise promise: aResult asAsyncPromise
]

{ #category : #'api - announcement handling' }
GtMagritteAsyncElementPromiseHandler >> onAnnouncement: anAnnouncement [

	self handleResult: anAnnouncement result
]
