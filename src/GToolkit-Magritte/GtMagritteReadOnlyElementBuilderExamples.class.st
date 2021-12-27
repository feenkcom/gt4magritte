Class {
	#name : #GtMagritteReadOnlyElementBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - builder' }
GtMagritteReadOnlyElementBuilderExamples >> basicBuilder [

	<gtExample>
	| aBuilder |
	aBuilder := GtMagritteReadOnlyElementBuilder new.

	^ aBuilder
]

{ #category : #'examples - simple address' }
GtMagritteReadOnlyElementBuilderExamples >> builderWithSimpleAddress [

	<gtExample>
	| aBuilder anAddress aDescription |
	aBuilder := self basicBuilder.
	anAddress := self simpleAddress.
	aDescription := self simpleAddressDescription.

	aBuilder object: anAddress.
	aBuilder objectDescription: aDescription.
	
	self assert: aBuilder object equals: anAddress.
	self assert: aBuilder objectDescription equals: aDescription.

	^ aBuilder
]

{ #category : #'examples - simple address' }
GtMagritteReadOnlyElementBuilderExamples >> elementWithSimpleAddress [

	<gtExample>
	| aBuilder anElement |
	aBuilder := self builderWithSimpleAddress.

	anElement := aBuilder asElement.
	
	self assert: anElement isNotNil.
	self assert: anElement childrenCount equals: 4.

	^ anElement
]

{ #category : #'examples - simple address' }
GtMagritteReadOnlyElementBuilderExamples >> simpleAddress [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse 18').
		  (#city -> 'Chamoille') } asDictionary
]

{ #category : #'examples - simple address' }
GtMagritteReadOnlyElementBuilderExamples >> simpleAddressDescription [

	<gtExample>
	^ MAPriorityContainer withAll: { 
			  (MAStringDescription new
				   accessor: (MADictionaryAccessor key: #street);
				   comment: 'Street name and number').
			  (MAStringDescription new
				   accessor: (MADictionaryAccessor key: #city);
				   comment: 'City name';
				   beRequired) }
]
