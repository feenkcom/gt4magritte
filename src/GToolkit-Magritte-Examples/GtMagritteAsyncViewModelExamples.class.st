Class {
	#name : #GtMagritteAsyncViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-Examples-Core'
}

{ #category : #'examples - person with two addresses' }
GtMagritteAsyncViewModelExamples >> asyncViewModelWithPersonObjectWithTwoAddresses [

	<gtExample>
	| aViewModel anObject aResult |
	anObject := self personObjectWithTwoAddresses.
	aViewModel := GtMagritteAsyncViewModel forObject: anObject.
	
	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - primary address' }
GtMagritteAsyncViewModelExamples >> asyncViewModelWithPrimaryAddress [

	<gtExample>
	| aViewModel anObject aResult |
	anObject := self primaryAddressObject.
	aViewModel := GtMagritteAsyncViewModel forObject: anObject.
	
	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - simple baseline' }
GtMagritteAsyncViewModelExamples >> asyncViewModelWithSimpleBaseline [

	<gtExample>
	| aViewModel anObject aResult aDescription |
	anObject := self simpleBaselineObject.
	aDescription := self simpleBaselineDescription.
	aViewModel := GtMagritteAsyncViewModel
		              forObject: anObject
		              description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtMagritteAsyncViewModelExamples >> basicAsyncViewModel [

	<gtExample>
	| aViewModel |
	aViewModel := GtMagritteAsyncViewModel new.

	self assert: aViewModel mementoFuture isNil.

	^ aViewModel
]

{ #category : #'examples - person with two addresses' }
GtMagritteAsyncViewModelExamples >> elementWithPersonObjectWithTwoAddresses [

	<gtExample>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithPersonObjectWithTwoAddresses.
	anElement := aViewModel asElement.
	
	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - person with two addresses' }
GtMagritteAsyncViewModelExamples >> elementWithPersonObjectWithTwoAddresses_TwiceAsElement [

	<gtExample>
	| aViewModel anElementOne anElementTwo |
	aViewModel := self asyncViewModelWithPersonObjectWithTwoAddresses.
	anElementOne := aViewModel asElement.
	anElementTwo := aViewModel asElement.

	self assert: anElementOne isNotNil.
	self assert: anElementTwo isNotNil.
	self assert: anElementOne ~= anElementTwo.

	^ BrVerticalPane new
		  matchParent;
		  addChild: anElementOne;
		  addChild: anElementTwo
]

{ #category : #'examples - primary address' }
GtMagritteAsyncViewModelExamples >> elementWithPrimaryAddress [

	<gtExample>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithPrimaryAddress.
	anElement := aViewModel asElement.
	
	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - primary address' }
GtMagritteAsyncViewModelExamples >> elementWithPrimaryAddress_TwiceAsElement [

	<gtExample>
	| aViewModel anElementOne anElementTwo |
	aViewModel := self asyncViewModelWithPrimaryAddress.
	anElementOne := aViewModel asElement.
	anElementTwo := aViewModel asElement.

	self assert: anElementOne isNotNil.
	self assert: anElementTwo isNotNil.
	self assert: anElementOne ~= anElementTwo.

	^ BrVerticalPane new
		  fitContent;
		  cellSpacing: 20;
		  addChild: anElementOne;
		  addChild: anElementTwo
]

{ #category : #'examples - simple baseline' }
GtMagritteAsyncViewModelExamples >> elementWithSimpleBaseline [

	<gtExample>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithSimpleBaseline.
	anElement := aViewModel asElement.
	
	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - model' }
GtMagritteAsyncViewModelExamples >> personObjectWithTwoAddresses [

	<gtExample>
	^ GtMagritteModelExamples new personObjectWithTwoAddresses
]

{ #category : #'examples - model' }
GtMagritteAsyncViewModelExamples >> primaryAddressObject [

	<gtExample>
	^ GtMagritteModelExamples new primaryAddressObject
]

{ #category : #'examples - model' }
GtMagritteAsyncViewModelExamples >> simpleBaselineDescription [

	<gtExample>
	^ GtMagritteModelExamples new simpleBaselineDescription
]

{ #category : #'examples - model' }
GtMagritteAsyncViewModelExamples >> simpleBaselineObject [

	<gtExample>
	^ GtMagritteModelExamples new simpleBaselineObject
]
