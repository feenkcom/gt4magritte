Class {
	#name : #GtMagritteDummyPostalAddress,
	#superclass : #Object,
	#instVars : [
		'street',
		'city'
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
		  priority: 2
]

{ #category : #'magritte-accessing' }
GtMagritteDummyPostalAddress >> descriptionStreet [

	<magritteDescription>
	^ MAStringDescription new
		  accessor: #street;
		  default: '';
		  priority: 1
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> street [

	^ street
]

{ #category : #accessing }
GtMagritteDummyPostalAddress >> street: anObject [

	street := anObject
]
