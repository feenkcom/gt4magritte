Class {
	#name : #GtMagritteModelExamples,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Examples-Core'
}

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressObject [

	<gtExample>
	| anAddress |
	anAddress := self basicAddressObject.

	anAddress
		street: 'Husova 108/12';
		city: 'Všetín'.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> addressTwoObject [

	<gtExample>
	| anAddress |
	anAddress := self basicAddressObject.

	anAddress
		street: 'Básníkova 72/21';
		city: 'Hodonín'.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> basicAddressObject [

	<gtExample>
	| anAddress |
	anAddress := GtMagritteDummyPostalAddress new.

	^ anAddress
]

{ #category : #'examples - broken object' }
GtMagritteModelExamples >> basicBrokenObject [

	<gtExample>
	| anObject |
	anObject := GtMagritteDummyModelWithBrokenDescription new.

	self assert: anObject value isNil.

	^ anObject
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> basicPersonObject [

	<gtExample>
	| aPerson |
	aPerson := GtMagritteDummyPerson new.

	self assert: aPerson name isNil.
	self assert: aPerson addresses isEmpty.

	^ aPerson
]

{ #category : #'examples - broken object' }
GtMagritteModelExamples >> brokenObject [

	<gtExample>
	| anObject |
	anObject := self basicBrokenObject.
	anObject value: 'I have a value'.
	anObject comment: 'I have a comment'.

	self assert: anObject value equals:'I have a value' .
	self assert: anObject comment equals: 'I have a comment'.

	^ anObject
]

{ #category : #'examples - person' }
GtMagritteModelExamples >> personObjectWithTwoAddresses [

	<gtExample>
	| aPerson anAddressOne anAddressTwo |
	aPerson := self basicPersonObject.

	aPerson name: 'Adélka'.
	anAddressOne := self primaryAddressObject.
	anAddressTwo := self addressTwoObject.
	aPerson addresses: { 
			anAddressOne.
			anAddressTwo }.

	self assert: aPerson name equals: 'Adélka'.
	self assert: aPerson addresses size equals: 2.

	^ aPerson
]

{ #category : #'examples - address' }
GtMagritteModelExamples >> primaryAddressObject [

	<gtExample>
	| anAddress |
	anAddress := self addressObject.

	anAddress isPrimary: true.

	^ anAddress
]

{ #category : #'examples - simple address' }
GtMagritteModelExamples >> simpleAddressDescription [

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

{ #category : #'examples - simple address' }
GtMagritteModelExamples >> simpleAddressObject [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse 18').
		  (#city -> 'Chamoille') } asDictionary
]

{ #category : #'examples - simple baseline' }
GtMagritteModelExamples >> simpleBaselineDescription [

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

{ #category : #'examples - simple baseline' }
GtMagritteModelExamples >> simpleBaselineObject [

	<gtExample>
	^ { (#baseline -> 'BaselineOfMyProject') } asDictionary
]

{ #category : #'examples - simple address' }
GtMagritteModelExamples >> simpleInvalidAddressObject [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse').
		  (#city -> '345 01 Chamoille') } asDictionary
]
