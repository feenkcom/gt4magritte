Class {
	#name : #GtMagritteNewEditableElementBuilderExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - simple address' }
GtMagritteNewEditableElementBuilderExamples >> basicBuilder [

	<gtExample>
	| aBuilder |
	aBuilder := GtMagritteNewEditableElementBuilder new.

	^ aBuilder
]

{ #category : #'examples - simple address' }
GtMagritteNewEditableElementBuilderExamples >> builderWithSimpleAddress [

	<gtExample>
	| aBuilder aMemento aDescription |
	aBuilder := self basicBuilder.
	aMemento := self mementoWithValidAddress.

	aBuilder memento: aMemento.
	
	self assert: aBuilder memento equals: aMemento.

	^ aBuilder
]

{ #category : #accessing }
GtMagritteNewEditableElementBuilderExamples >> elementWithSimpleAddress [

	<gtExample>
	| aBuilder anElement |
	aBuilder := self builderWithSimpleAddress.

	anElement := aBuilder asElement.
	
	self assert: anElement isNotNil.
	self assert: anElement childrenCount equals: 4.

	^ anElement
]

{ #category : #'examples - simple address' }
GtMagritteNewEditableElementBuilderExamples >> mementoWithValidAddress [

	<gtExample>
	^ GtMagritteMementoExamples new mementoWithValidAddress
]
