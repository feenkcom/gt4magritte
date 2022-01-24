Class {
	#name : #GtMagritteAsyncMementoAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'observable',
		'model'
	],
	#category : #'GToolkit-Magritte-Core-Support'
}

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> memento: anObject [

	memento := anObject
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> model [

	^ model
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> model: anObject [

	model := anObject
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> observable [

	^ observable
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> observable: anObject [

	observable := anObject
]

{ #category : #accessing }
GtMagritteAsyncMementoAnnouncementHandler >> onAnnouncement: anAnnouncement [

	| aNewValue aCurrentValue aMergedValue |
	aNewValue := GtMagritteAsyncBuilderUtility
		             createValueFrom: self model
		             using: self description.

	aCurrentValue := self observable valueOrNil.

	aCurrentValue ifNil: [ 
		self observable value: aNewValue.
		^ self ].

	aMergedValue := aCurrentValue copyWithOriginalValue:
		                aNewValue originalValue.

	self observable value: aMergedValue
]
