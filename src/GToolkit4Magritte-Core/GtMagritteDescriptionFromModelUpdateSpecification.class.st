Class {
	#name : #GtMagritteDescriptionFromModelUpdateSpecification,
	#superclass : #Object,
	#instVars : [
		'descriptionSetterSelector',
		'modelValueSelector',
		'announcementClass',
		'announcerBlock'
	],
	#category : #'GToolkit4Magritte-Core-Description Properties'
}

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> announcementClass [
	^ announcementClass
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> announcementClass: anObject [
	announcementClass := anObject
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> announcerBlock [
	^ announcerBlock
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> announcerBlock: anObject [
	announcerBlock := anObject
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> announcerDo: aBlock [
	self announcerBlock ifNil: [ ^ self ].
	self announcerBlock value ifNotNil: aBlock
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> descriptionSetterSelector [
	^ descriptionSetterSelector
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> descriptionSetterSelector: anObject [
	descriptionSetterSelector := anObject
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> modelValueSelector [
	^ modelValueSelector
]

{ #category : #accessing }
GtMagritteDescriptionFromModelUpdateSpecification >> modelValueSelector: anObject [
	modelValueSelector := anObject
]

{ #category : #'api - subscriptions' }
GtMagritteDescriptionFromModelUpdateSpecification >> subscribeInContext: aContext [
	| aHandler |
	self subscriptionBuilderDo: [ :aSubscriptionBuilder | 
		aHandler := GtMagritteDescriptionConfigurationFromModelAnnouncementHandler new
			context: aContext;
			descriptionSetterSelector: self descriptionSetterSelector;
			modelValueSelector: self modelValueSelector;
			announcementClass: self announcementClass.
	
		aSubscriptionBuilder
			when: self announcementClass
			send: #onAnnouncement:
			to: aHandler
	].
	
	^ aHandler
]

{ #category : #private }
GtMagritteDescriptionFromModelUpdateSpecification >> subscriptionBuilderDo: aBlock [
	self announcerDo: [ :anAnnouncer | 
		| aSubscriptionBuilder |
		aSubscriptionBuilder := (anAnnouncer respondsTo: #weak)
			ifTrue: [ [ anAnnouncer weak ] onDNU: #weak do: [ anAnnouncer ] ]
			ifFalse: [ anAnnouncer ].
		aSubscriptionBuilder ifNotNil: aBlock
	]
]
