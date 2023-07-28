Class {
	#name : #GtMagritteDescriptionValueFromModelUpdateSpecification,
	#superclass : #Object,
	#instVars : [
		'announcementClass',
		'announcerBlock'
	],
	#category : #'GToolkit4Magritte-Core-Description Properties'
}

{ #category : #accessing }
GtMagritteDescriptionValueFromModelUpdateSpecification >> announcementClass [
	^ announcementClass
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelUpdateSpecification >> announcementClass: anObject [
	announcementClass := anObject
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelUpdateSpecification >> announcerBlock [
	^ announcerBlock
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelUpdateSpecification >> announcerBlock: anObject [
	announcerBlock := anObject
]

{ #category : #accessing }
GtMagritteDescriptionValueFromModelUpdateSpecification >> announcerDo: aBlock [
	self announcerBlock ifNil: [ ^ self ].
	self announcerBlock value ifNotNil: aBlock
]

{ #category : #'api - subscriptions' }
GtMagritteDescriptionValueFromModelUpdateSpecification >> subscribeInContext: aContext [
	| aHandler |
	self subscriptionBuilderDo: [ :aSubscriptionBuilder | 
		aHandler := GtMagritteDescriptionValueFromModelAnnouncementHandler new
			context: aContext;
			announcementClass: self announcementClass.
	
		aSubscriptionBuilder
			when: self announcementClass
			send: #onAnnouncement:
			to: aHandler
	].
	
	^ aHandler
]

{ #category : #private }
GtMagritteDescriptionValueFromModelUpdateSpecification >> subscriptionBuilderDo: aBlock [
	self announcerDo: [ :anAnnouncer | 
		| aSubscriptionBuilder |
		aSubscriptionBuilder := (anAnnouncer respondsTo: #weak)
			ifTrue: [ [ anAnnouncer weak ] onDNU: #weak do: [ anAnnouncer ] ]
			ifFalse: [ anAnnouncer ].
		aSubscriptionBuilder ifNotNil: aBlock
	]
]
