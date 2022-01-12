Class {
	#name : #GtMagritteModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressDescription [

	<gtExample>
	^ MAPriorityContainer withAll: { 
			  (MAStringDescription new
				   accessor: (MADictionaryAccessor key: #street);
				   comment: 'Street name and number';
				   addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
				   labelled: 'Street must be non empty';
				   addCondition: [ :aValue | 
					   (aValue select: [ :e | e isDigit ]) isNotEmpty ]
				   labelled: 'Street must include street number').
			  (MAStringDescription new
				   accessor: (MADictionaryAccessor key: #city);
				   comment: 'City name';
				   beRequired;
				   addCondition: [ :aValue | aValue trimBoth isNotEmpty ]
				   labelled: 'City must be non empty';
				   addCondition: [ :aValue | aValue allSatisfy: #isLetter ]
				   labelled: 'City must include letters only') }
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressObject [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse 18').
		  (#city -> 'Chamoille') } asDictionary
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> invalidAddressObject [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse').
		  (#city -> '345 01 Chamoille') } asDictionary
]
