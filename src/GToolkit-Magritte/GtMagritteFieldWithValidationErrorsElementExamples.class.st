Class {
	#name : #GtMagritteFieldWithValidationErrorsElementExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples'
}

{ #category : #'examples - element' }
GtMagritteFieldWithValidationErrorsElementExamples >> basicElement [

	<gtExample>
	| anElement anIssuesElement |
	anElement := GtMagritteFieldWithValidationErrorsElement new.

	anIssuesElement := anElement childNamed: #issues.
	self assert: anIssuesElement visibility equals: BlVisibility gone.
	self assert: anIssuesElement text isEmpty.

	^ anElement
]

{ #category : #'examples - view model' }
GtMagritteFieldWithValidationErrorsElementExamples >> basicFieldViewModel [

	<gtExample>
	| aViewModel anElement |
	aViewModel := GtMagritteFieldWithValidationErrorsViewModel new.

	self assert: aViewModel memento isNil.
	self assert: aViewModel description isNil.
	self assert: aViewModel hasIssues not.

	anElement := aViewModel fieldStencil asElement.

	self assert: anElement isNotNil.
	self assert: (anElement isKindOf: BlElement).

	^ aViewModel
]

{ #category : #'examples - element' }
GtMagritteFieldWithValidationErrorsElementExamples >> elementWithFutureIssues [

	<gtExample>
	| aViewModel anElement anIssuesElement |
	anElement := self basicElement.
	aViewModel := self fieldViewModelWithFutureIssues.
	anElement fieldViewModel: aViewModel.

	anIssuesElement := anElement childNamed: #issues.
	self assert: anIssuesElement visibility equals: BlVisibility gone.
	self assert: anIssuesElement text isEmpty.

	^ anElement
]

{ #category : #'examples - element' }
GtMagritteFieldWithValidationErrorsElementExamples >> elementWithIssues [

	<gtExample>
	| aViewModel anElement anIssuesElement |
	anElement := self basicElement.
	aViewModel := self fieldViewModelWithIssues.
	anElement fieldViewModel: aViewModel.

	anIssuesElement := anElement childNamed: #issues.
	self assert: anIssuesElement visibility equals: BlVisibility visible.
	self
		assert: anIssuesElement text asString
		equals: 'Street must include street number'.

	^ anElement
]

{ #category : #'examples - view model' }
GtMagritteFieldWithValidationErrorsElementExamples >> fieldViewModelWithFutureIssues [

	<gtExample>
	| aViewModel aMemento aDescription |
	aViewModel := self basicFieldViewModel.
	aMemento := self simpleAddressWithIssuesMemento.
	aDescription := self streetAddressDescription: aMemento.

	aViewModel memento: aMemento.
	aViewModel description: aDescription.

	self assert: aViewModel hasIssues not.

	^ aViewModel
]

{ #category : #accessing }
GtMagritteFieldWithValidationErrorsElementExamples >> fieldViewModelWithIssues [

	<gtExample>
	| aViewModel anObject aDescription |
	aViewModel := self fieldViewModelWithFutureIssues.

	[ aViewModel memento validate ]
		on: MAValidationError
		do: [ :anError | aViewModel notifyValidationError: anError ].

	self assert: aViewModel hasIssues.

	^ aViewModel
]

{ #category : #'examples - object' }
GtMagritteFieldWithValidationErrorsElementExamples >> simpleAddress [

	^ GtMagritteEditableElementBuilderExamples new simpleAddress
]

{ #category : #'examples - object' }
GtMagritteFieldWithValidationErrorsElementExamples >> simpleAddressDescription [

	^ GtMagritteEditableElementBuilderExamples new
		  simpleAddressDescription
]

{ #category : #'examples - object' }
GtMagritteFieldWithValidationErrorsElementExamples >> simpleAddressMemento [

	<gtExample>
	| anObject aDescription aMemento |
	anObject := self simpleAddress.
	aDescription := self simpleAddressDescription.

	aMemento := anObject mementoClass
		            model: anObject
		            description: aDescription.

	aMemento validate.

	^ aMemento
]

{ #category : #'examples - object' }
GtMagritteFieldWithValidationErrorsElementExamples >> simpleAddressWithIssuesMemento [

	<gtExample>
	| aMemento anIssueCount |
	aMemento := self simpleAddressMemento.

	aMemento
		write: 'Werkstrasse'
		using: aMemento magritteDescription children first.
	aMemento
		write: '432 12 Chamoille'
		using: aMemento magritteDescription children second.

	[ aMemento validate ]
		on: MAMultipleErrors
		do: [ :anError | anIssueCount := anError collection size ].

	self assert: anIssueCount equals: 2.

	^ aMemento
]

{ #category : #'examples - object' }
GtMagritteFieldWithValidationErrorsElementExamples >> streetAddressDescription: aMemento [

	<gtExample>
	| aStreetDescription |
	aStreetDescription := aMemento magritteDescription children first.
	
	self assert: aStreetDescription label equals: 'Street'.
	
	^ aStreetDescription
]
