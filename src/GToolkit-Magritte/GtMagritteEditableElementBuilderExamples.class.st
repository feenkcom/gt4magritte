"
I exemplify {{gtClass:GtMagritteElementBuilder}}.

"
Class {
	#name : #GtMagritteEditableElementBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - builder' }
GtMagritteEditableElementBuilderExamples >> basicBuilder [

	<gtExample>
	| aBuilder |
	aBuilder := GtMagritteEditableElementBuilder new.

	^ aBuilder
]

{ #category : #'examples - simple address' }
GtMagritteEditableElementBuilderExamples >> builderWithSimpleAddress [

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
GtMagritteEditableElementBuilderExamples >> builderWithSimpleAddressAndActions [

	<gtExample>
	| aBuilder |
	aBuilder := self builderWithSimpleAddress.

	aBuilder addButtons.
	
	self assert: aBuilder actions size equals: 2.

	^ aBuilder
]

{ #category : #'examples - simple address' }
GtMagritteEditableElementBuilderExamples >> elementWithSimpleAddress [

	<gtExample>
	| aBuilder anElement |
	aBuilder := self builderWithSimpleAddress.

	anElement := aBuilder asElement.
	
	self assert: anElement isNotNil.
	self assert: anElement childrenCount equals: 4.

	^ anElement
]

{ #category : #'examples - simple address' }
GtMagritteEditableElementBuilderExamples >> elementWithSimpleAddressAndActions [

	<gtExample>
	| aBuilder anElement |
	aBuilder := self builderWithSimpleAddressAndActions.

	anElement := aBuilder asElement.
	
	self assert: anElement isNotNil.
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) childrenCount equals: 4.
	self assert: (anElement childAt: 2) childrenCount equals: 2.

	^ anElement
]

{ #category : #'examples - simple address' }
GtMagritteEditableElementBuilderExamples >> simpleAddress [

	<gtExample>
	^ { 
		  (#street -> 'Werkstrasse 18').
		  (#city -> 'Chamoille') } asDictionary
]

{ #category : #'examples - simple address' }
GtMagritteEditableElementBuilderExamples >> simpleAddressDescription [

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
