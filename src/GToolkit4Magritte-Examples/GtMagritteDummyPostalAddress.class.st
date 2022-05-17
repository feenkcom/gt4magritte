Class {
	#name : #GtMagritteDummyPostalAddress,
	#superclass : #Object,
	#instVars : [
		'street',
		'city',
		'isPrimary',
		'announcer',
		'zipCode'
	],
	#category : #'GToolkit4Magritte-Examples-Support'
}

{ #category : #subscriptions }
GtMagritteDummyPostalAddress >> announce: anAnnouncement [

	announcer ifNil: [ ^ self ].

	announcer announce: anAnnouncement
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> city [

	^ city
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> city: anObject [

	city := anObject
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddress >> descriptionCity [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: #city;
		  default: '';
		  priority: 2;
		  beRequired;
		  addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
		  labelled: 'City must be non empty';
		  addCondition: [ :aValue | aValue allSatisfy: #isLetter ]
		  labelled: 'City must include letters only'
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddress >> descriptionIsPrimary [

	<magritteDescription>
	^ MABooleanDescription new
		  label: 'Primary';
		  accessor: #isPrimary;
		  default: false;
		  priority: 10;
		  trueString: 'is primary';
		  falseString: '';
		  updateOn: GtMagritteDummyPostalAddressIsPrimaryChanged from: [ self ];
		  blocActionString: 'set as primary';
		  blocUseDropdown: true
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddress >> descriptionStreet [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: #street;
		  default: '';
		  priority: 1;
		  beRequired;
		  updateOn: GtMagritteDummyPostalAddressStreetChanged
		  from: [ self ];
		  addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
		  labelled: 'Street must be non empty';
		  addCondition: [ :aValue | 
			  (aValue select: [ :e | e isDigit ]) isNotEmpty ]
		  labelled: 'Street must include street number'
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddress >> descriptionZipCode [

	<magritteDescription>
	^ MANumberDescription new
		  accessor: #zipCode;
		  default: 1000;
		  priority: 3;
		  kind: Object
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> isPrimary [

	^ isPrimary ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> isPrimary: aBoolean [

	isPrimary = aBoolean ifTrue: [ ^ self ].
	
	aBoolean ifTrue: [ 
		self requestToBePrimaryAddress ifFalse: [ ^ self ] ].

	isPrimary := aBoolean.
	
	self notifyPrimaryChanged.
]

{ #category : #'private - notifying' }
GtMagritteDummyPostalAddress >> notifyPrimaryChanged [

	announcer ifNil: [ ^ self ].

	self announce: (GtMagritteDummyPostalAddressIsPrimaryChanged new
			 address: self;
			 isPrimary: self isPrimary)
]

{ #category : #'private - notifying' }
GtMagritteDummyPostalAddress >> notifyStreetChanged [

	announcer ifNil: [ ^ self ].

	self announce: (GtMagritteDummyPostalAddressStreetChanged new
			 address: self;
			 street: self street)
]

{ #category : #'private - notifying' }
GtMagritteDummyPostalAddress >> requestToBePrimaryAddress [

	| aRequest |
	announcer ifNil: [ ^ true ].

	self announce:
		(aRequest := GtMagritteDummyBePrimaryPostalAddressRequest new
			             address: self;
			             response: true).

	^ aRequest response ifNil: [ true ]
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> street [

	^ street
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> street: anObject [

	street = anObject ifTrue: [ ^ self ].

	street := anObject.
	
	self notifyStreetChanged.
]

{ #category : #subscriptions }
GtMagritteDummyPostalAddress >> unsubscribe: aReceiver [

	announcer ifNil: [ ^ self ].

	^ announcer unsubscribe: aReceiver
]

{ #category : #subscriptions }
GtMagritteDummyPostalAddress >> weak [

	^ self
]

{ #category : #subscriptions }
GtMagritteDummyPostalAddress >> when: anAnnnouncement send: aSelector to: aReceiver [

	announcer ifNil: [ announcer := Announcer new ].

	^ announcer weak when: anAnnnouncement send: aSelector to: aReceiver
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> zipCode [
	^ zipCode
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> zipCode: aNumber [
	zipCode := aNumber
]
