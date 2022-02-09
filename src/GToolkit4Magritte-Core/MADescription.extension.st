Extension { #name : #MADescription }

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> announcerSubscriptionsDo: aBlock [

	"Iterates over all subscriptions: anAnnouncementClass -> anAnnouncerBlock"

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | 
			aCollection do: [ :anAssoc | 
				aBlock value: anAssoc key value: anAssoc value ] ]
		ifAbsent: [ "ignore" ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> beAlwaysEditable [

	self propertyAt: #alwaysEditable put: true
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> definingMethod [

	^ self propertyAt: #definingMethod ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> definingMethod: aDefiningMethod [

	self propertyAt: #definingMethod put: aDefiningMethod
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> gtConditionsFor: aView [

	<gtView>
	(self hasProperty: #conditions) ifFalse: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Conditions';
		  priority: 55;
		  items: [ self conditions ];
		  column: 'Valuable' text: #key;
		  column: 'Description' text: #value;
		  send: #key
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> hasDefiningMethod [

	^ self hasProperty: #definingMethod
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> isAlwaysEditable [

	^ self propertyAt: #alwaysEditable ifAbsent: [ false ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription class >> new [

	| anInstance aDefiningMethod |
	anInstance := super new.

	aDefiningMethod := GtMagritteDefiningMethod fromStack:
		                   thisContext stack.
	aDefiningMethod ifNotNil: [ 
		anInstance definingMethod: aDefiningMethod ].

	^ anInstance
]

{ #category : #'*GToolkit4Magritte-Core' }
MADescription >> updateOn: anAnnouncementClass from: anAnnouncerBlock [

	self
		propertyAt: #announcerSubscriptions
		ifPresent: [ :aCollection | 
			aCollection add: anAnnouncementClass -> anAnnouncerBlock ]
		ifAbsentPut: [ 
			OrderedCollection with: anAnnouncementClass -> anAnnouncerBlock ]
]
