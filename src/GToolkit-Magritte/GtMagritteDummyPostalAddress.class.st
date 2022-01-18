Class {
	#name : #GtMagritteDummyPostalAddress,
	#superclass : #Object,
	#instVars : [
		'street',
		'city',
		'isPrimary'
	],
	#category : #'GToolkit-Magritte-Examples - Support'
}

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
		  accessor: #isPrimary;
		  default: false;
		  priority: 10;
		  trueString: 'primary';
		  falseString: 'set as primary'
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddress >> descriptionStreet [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: #street;
		  default: '';
		  priority: 1;
		  beRequired;
		  addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
		  labelled: 'Street must be non empty';
		  addCondition: [ :aValue | 
			  (aValue select: [ :e | e isDigit ]) isNotEmpty ]
		  labelled: 'Street must include street number'
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> isPrimary [

	^ isPrimary ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> isPrimary: anObject [

	isPrimary := anObject
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> street [

	^ street
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> street: anObject [

	street := anObject
]
