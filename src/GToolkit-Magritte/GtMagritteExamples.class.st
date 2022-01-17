Class {
	#name : #GtMagritteExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - address' }
GtMagritteExamples >> address [

	<gtExample>
	| anAddress |
	anAddress := self basicAddress.

	anAddress
		street: 'Husova 108/12';
		city: 'Všetín'.

	^ anAddress
]

{ #category : #'examples - address' }
GtMagritteExamples >> addressTwo [

	<gtExample>
	| anAddress |
	anAddress := self basicAddress.

	anAddress
		street: 'Básníkova 72/21';
		city: 'Hodonín'.

	^ anAddress
]

{ #category : #'examples - baseline' }
GtMagritteExamples >> baseline [

	<gtExample>
	^ { (#baseline -> 'BaselineOfMyProject') } asDictionary
]

{ #category : #'examples - baseline' }
GtMagritteExamples >> baselineDescription [

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
GtMagritteExamples >> basicAddress [

	<gtExample>
	| anAddress |
	anAddress := GtMagritteDummyPostalAddress new.

	^ anAddress
]

{ #category : #'examples - person' }
GtMagritteExamples >> basicPerson [

	<gtExample>
	| aPerson |
	aPerson := GtMagritteDummyPerson new.

	self assert: aPerson name isNil.
	self assert: aPerson addresses isEmpty.

	^ aPerson
]

{ #category : #'examples - person' }
GtMagritteExamples >> personWithTwoAddresses [

	<gtExample>
	| aPerson anAddressOne anAddressTwo |
	aPerson := self basicPerson.

	aPerson name: 'Adélka'.
	anAddressOne := self address.
	anAddressTwo := self addressTwo.
	aPerson addresses: { 
			self address.
			self addressTwo }.

	self assert: aPerson name equals: 'Adélka'.
	self assert: aPerson addresses size equals: 2.

	^ aPerson
]
