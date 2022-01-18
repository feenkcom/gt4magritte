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

{ #category : #'examples - address' }
GtMagritteExamples >> primaryAddress [

	<gtExample>
	| anAddress |
	anAddress := self address.

	anAddress isPrimary: true.

	^ anAddress
]
