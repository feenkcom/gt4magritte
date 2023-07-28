Class {
	#name : #GtMagritteMementoAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'observable',
		'model',
		'announcementClass'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #testing }
GtMagritteMementoAnnouncementHandler class >> isDeprecated [
	^ true
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> announcementClass [

	^ announcementClass
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> announcementClass: anObject [

	announcementClass := anObject
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> description [

	^ description
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> memento: anObject [

	memento := anObject
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> model [

	^ model
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> model: anObject [

	model := anObject
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> observable [

	^ observable
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> observable: anObject [

	observable := anObject
]

{ #category : #accessing }
GtMagritteMementoAnnouncementHandler >> onAnnouncement: anAnnouncement [

	| aNewValue aCurrentValue aMergedValue |
	aNewValue := GtMagritteBuilderUtility
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
