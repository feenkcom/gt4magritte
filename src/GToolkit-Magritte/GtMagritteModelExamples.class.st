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
				   addCondition: [ :aValue | 
					   aValue allSatisfy: [ :each | 
							   each isLetter or: [ each isSeparator ] ] ]
				   labelled: 'City must include letters only') }
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressObject [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse 18').
		  (#city -> 'Chamoille') } asDictionary
]

{ #category : #'examples - baseline' }
GtMagritteModelExamples >> baseline [

	<gtExample>
	^ { (#baseline -> 'BaselineOfMyProject') } asDictionary
]

{ #category : #'examples - baseline' }
GtMagritteModelExamples >> baselineDescription [

	<gtExample>
	^ MAPriorityContainer withAll: { (MAStringDescription new
			   accessor: (MADictionaryAccessor key: #baseline);
			   beAlwaysEditable;
			   blocCompletion: [ GtClassesCompletionStrategy new ];
			   beRequired;
			   addCondition: [ :aValue | aValue beginsWith: 'BaselineOf' ]
			   labelled: 'Baseline name must begin with BaselineOf';
			   addCondition: [ :aValue | 
				   (Smalltalk globals includesKey: aValue asSymbol) not ]
			   labelled: 'Baseline name must be a non-existent class';
			   comment: 'Baseline name') }
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> invalidAddressObject [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse').
		  (#city -> '345 01 Chamoille') } asDictionary
]
