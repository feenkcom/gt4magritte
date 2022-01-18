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

{ #category : #'examples - baseline' }
GtMagritteEditableElementBuilderExamples >> builderWithBaseline [

	<gtExample>
	| aBuilder aBaseline aDescription |
	aBuilder := self basicBuilder.
	aBaseline := self simpleBaseline.
	aDescription := self simpleBaselineDescription.

	aBuilder object: aBaseline.
	aBuilder objectDescription: aDescription.
	aBuilder addButtons.

	self assert: aBuilder object equals: aBaseline.
	self assert: aBuilder objectDescription equals: aDescription.

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

{ #category : #'examples - baseline' }
GtMagritteEditableElementBuilderExamples >> elementWithBaseline [

	<gtExample>
	| aBuilder anElement |
	aBuilder := self builderWithBaseline.

	anElement := aBuilder asElement.

	self assert: anElement childrenCount equals: 2.

	^ anElement
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
	^ GtMagritteModelExamples new addressObject
]

{ #category : #'examples - simple address' }
GtMagritteEditableElementBuilderExamples >> simpleAddressDescription [

	<gtExample>
	^ GtMagritteModelExamples new addressDescription
]

{ #category : #'examples - baseline' }
GtMagritteEditableElementBuilderExamples >> simpleBaseline [

	<gtExample>
	^ GtMagritteModelExamples new baseline
]

{ #category : #'examples - baseline' }
GtMagritteEditableElementBuilderExamples >> simpleBaselineDescription [

	<gtExample>
	^ GtMagritteModelExamples new baselineDescription
]
