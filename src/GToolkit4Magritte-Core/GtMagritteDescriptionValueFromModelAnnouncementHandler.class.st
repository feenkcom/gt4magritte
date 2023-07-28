Class {
	#name : #GtMagritteDescriptionValueFromModelAnnouncementHandler,
	#superclass : #Object,
	#instVars : [
		'context',
		'announcementClass'
	],
	#category : #'GToolkit4Magritte-Core-Description Properties'
}

{ #category : #accessing }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> announcementClass [
	^ announcementClass
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> announcementClass: anObject [
	announcementClass := anObject
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> context [
	^ context
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> context: anObject [
	context := anObject
]

{ #category : #'gt - extensions' }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> gtDescriptionFor: aView [
	<gtView>
	self context ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Description';
		priority: 49;
		object: [ self context ];
		view: #gtDescriptionFor:
]

{ #category : #ui }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> label [
	| aText |
	aText := 'Change ' asRopedText.
	aText foreground: BrGlamorousColors disabledButtonTextColor.
	aText append: (self context description label) asRopedText.
	aText append: (' current value on ' asRopedText
		foreground: BrGlamorousColors disabledButtonTextColor).
	aText append: (self announcementClass name asRopedText).

	^ aText
]

{ #category : #'api - announcement handling' }
GtMagritteDescriptionValueFromModelAnnouncementHandler >> onAnnouncement: anAnnouncement [
	| aNewValue |
	aNewValue := GtMagritteBuilderUtility
		             createValueFrom: self context model
		             using: self context description.

	self context observable 
		ifSome: [ :aCurrentValue |
			| aMergedValue |
			aMergedValue := aCurrentValue copyWithOriginalValue: 
				aNewValue originalValue.
			self context observable value: aMergedValue ]
		ifNone: [ self context observable value: aNewValue ].
]
