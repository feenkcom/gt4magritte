Class {
	#name : #GtMagritteDescriptionConfigurationFromModelAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'context',
		'announcementClass',
		'descriptionSetterSelector',
		'modelValueSelector'
	],
	#category : #'GToolkit4Magritte-Core-Description Properties'
}

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> announcementClass [
	^ announcementClass
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> announcementClass: anObject [
	announcementClass := anObject
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> context [
	^ context
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> context: anObject [
	context := anObject
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> descriptionSetterSelector [
	^ descriptionSetterSelector
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> descriptionSetterSelector: anObject [
	descriptionSetterSelector := anObject
]

{ #category : #ui }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> label [
	| aText |
	aText := 'Change ' asRopedText.
	aText foreground: BrGlamorousColors disabledButtonTextColor.
	aText append: (self context description label) asRopedText.
	aText append: ('''s ' asRopedText).
	aText append: (self descriptionSetterSelector copyWithout: $:) asRopedText.
	aText append: (' property value on ' asRopedText
		foreground: BrGlamorousColors disabledButtonTextColor).
	aText append: (self announcementClass name asRopedText).

	^ aText
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> modelValueSelector [
	^ modelValueSelector
]

{ #category : #accessing }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> modelValueSelector: anObject [
	modelValueSelector := anObject
]

{ #category : #'api - announcement handling' }
GtMagritteDescriptionConfigurationFromModelAnnouncementHandler >> onAnnouncement: anAnnouncement [
	| aNewConfigurationValue |
	aNewConfigurationValue := self context model perform: self modelValueSelector.

	self context description
		perform: self descriptionSetterSelector
		with: aNewConfigurationValue
]
