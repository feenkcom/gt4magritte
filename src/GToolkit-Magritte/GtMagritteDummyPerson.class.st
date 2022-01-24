Class {
	#name : #GtMagritteDummyPerson,
	#superclass : #Object,
	#instVars : [
		'name',
		'addresses'
	],
	#category : #'GToolkit-Magritte-Examples - Support'
}

{ #category : #accessing }
GtMagritteDummyPerson >> addresses [

	^ addresses
]

{ #category : #accessing }
GtMagritteDummyPerson >> addresses: aCollection [

	addresses := aCollection.

	aCollection do: [ :eachAddress | 
		eachAddress
			when: GtMagritteDummyBePrimaryPostalAddressRequest
			send: #onPrimaryAddressRequest:
			to: self ]
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPerson >> descriptionName [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: #name;
		  default: '';
		  priority: 1;
		  beRequired;
		  addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
		  labelled: 'Name must be non empty'
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPerson >> desriptionAddresses [

	<magritteDescription>
	^ MAToManyRelationDescription new
		  accessor: #addresses;
		  default: #(  );
		  classes: { GtMagritteDummyPostalAddress };
		  priority: 2;
		  beModifiable;
		  blocItemStencil: [ :anItemObject :anItemIndex | 
			  anItemObject asElement
				  fitContent;
				  border:
					  (BlBorder
						   paint: BrGlamorousColors disabledButtonBorderColor
						   width: 1);
				  margin: (BlInsets
						   top: 0
						   right: 5
						   bottom: 5
						   left: 0);
				  padding: (BlInsets all: 5);
				  background: Color white ];
		  newItemStencil: [ GtMagritteDummyPostalAddress new ]
]

{ #category : #initialization }
GtMagritteDummyPerson >> initialize [

	super initialize.

	addresses := #(  )
]

{ #category : #accessing }
GtMagritteDummyPerson >> name [

	^ name
]

{ #category : #accessing }
GtMagritteDummyPerson >> name: anObject [

	name := anObject
]

{ #category : #'private - announcement handling' }
GtMagritteDummyPerson >> onPrimaryAddressRequest: anAnnouncement [

	self addresses do: [ :anAddress | 
		anAddress == anAnnouncement address ifFalse: [ 
			anAddress isPrimary: false ] ]
]
