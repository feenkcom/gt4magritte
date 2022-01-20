Class {
	#name : #GtMagritteAsyncViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Magritte-New-Examples'
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
		  fitContent;
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
