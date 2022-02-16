Class {
	#name : #GtMagritteViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Examples-Core'
}

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> asyncViewModelWithPersonObjectWithTwoAddresses [

	<gtExample>
	| aViewModel anObject aResult |
	anObject := self personObjectWithTwoAddresses.
	aViewModel := GtMagritteViewModel forObject: anObject.
	
	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> asyncViewModelWithPersonObjectWithTwoAddresses_WithAddressesDescriptionOnly [

	<gtExample>
	| aViewModel anObject aResult |
	anObject := self personObjectWithTwoAddresses.
	aViewModel := anObject asGtMagritteViewModelWithDescription: [ 
		              anObject descriptionPostalAddresses asContainer 
			              blocElementContainerStencil: [ :aMemento | 
				              BrVerticalPane new
					              in: [ :aPane | 
					              	"ignore field labels"
						              aPane magritte
							              beFieldContainer;
							              beToolbarContainer ];
					              fitContent ] ].

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - primary address' }
GtMagritteViewModelExamples >> asyncViewModelWithPrimaryAddress [

	<gtExample>
	| aViewModel anObject aResult |
	anObject := self primaryAddressObject.
	aViewModel := GtMagritteViewModel forObject: anObject.
	
	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - simple baseline' }
GtMagritteViewModelExamples >> asyncViewModelWithSimpleBaseline [

	<gtExample>
	| aViewModel anObject aResult aDescription |
	anObject := self simpleBaselineObject.
	aDescription := self simpleBaselineDescription.
	aViewModel := GtMagritteViewModel
		              forObject: anObject
		              description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #accessing }
GtMagritteViewModelExamples >> asyncViewModelWithSimpleBaselines [

	<gtExample>
	| aViewModel anObject aResult aDescription |
	anObject := GtMagritteModelExamples new simpleBaselinesObject.
	aDescription := GtMagritteModelExamples new
		                simpleBaselinesDescription.
	aViewModel := GtMagritteViewModel
		              forObject: anObject
		              description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtMagritteViewModelExamples >> basicAsyncViewModel [

	<gtExample>
	| aViewModel |
	aViewModel := GtMagritteViewModel new.

	self assert: aViewModel mementoBlock isNil.
	self assert: aViewModel mementoFuture isNotNil.

	^ aViewModel
]

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> elementWithPersonObjectWithTwoAddresses [

	<gtExample>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithPersonObjectWithTwoAddresses.
	anElement := aViewModel asElement.
	
	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> elementWithPersonObjectWithTwoAddresses_TwiceAsElement [

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
GtMagritteViewModelExamples >> elementWithPrimaryAddress [

	<gtExample>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithPrimaryAddress.
	anElement := aViewModel asElement.
	
	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - primary address' }
GtMagritteViewModelExamples >> elementWithPrimaryAddress_TwiceAsElement [

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
GtMagritteViewModelExamples >> elementWithSimpleBaseline [

	<gtExample>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithSimpleBaseline.
	anElement := aViewModel asElement.
	
	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> personObjectWithTwoAddresses [

	<gtExample>
	^ GtMagritteModelExamples new personObjectWithTwoAddresses
]

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> primaryAddressObject [

	<gtExample>
	^ GtMagritteModelExamples new primaryAddressObject
]

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> simpleBaselineDescription [

	<gtExample>
	^ GtMagritteModelExamples new simpleBaselineDescription
]

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> simpleBaselineObject [

	<gtExample>
	^ GtMagritteModelExamples new simpleBaselineObject
]

{ #category : #'examples - simple baselines' }
GtMagritteViewModelExamples >> viewModelWithBaselines [

	<gtExample>
	| aViewModel anObject aResult aDescription |
	anObject := GtMagritteModelExamples new simpleBaselinesObject.
	aDescription := GtMagritteModelExamples new
		                simpleBaselinesDescription.
	aViewModel := GtMagritteViewModel
		              forObject: anObject
		              description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - simple directory' }
GtMagritteViewModelExamples >> viewModelWithDirectory [

	<gtExample>
	| aViewModel anObject aResult aDescription |
	anObject := GtMagritteModelExamples new simpleDirectoryObject.
	aDescription := GtMagritteModelExamples new
		                simpleDirectoryDescription.
	aViewModel := GtMagritteViewModel
		              forObject: anObject
		              description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]
