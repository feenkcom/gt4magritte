Class {
	#name : #GtMagritteViewModelExamples,
	#superclass : #Object,
	#category : #'GToolkit4Magritte-Examples-Core'
}

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> asyncViewModelWithPersonObjectWithTwoAddresses [
	<gtExample>
	<return: #GtMagritteViewModel>
	| aViewModel anObject |
	anObject := self personObjectWithTwoAddresses.
	aViewModel := GtMagritteViewModel forObject: anObject.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> asyncViewModelWithPersonObjectWithTwoAddresses_WithAddressesDescriptionOnly [
	<gtExample>
	<return: #GtMagritteViewModel>
	| aViewModel anObject |
	anObject := self personObjectWithTwoAddresses.
	aViewModel := anObject
			asGtMagritteViewModelWithDescription: [ anObject descriptionPostalAddresses asContainer
					blocElementContainerStencil: [ :aMemento | 
						BrVerticalPane new
							in: [  "ignore field labels":aPane | 
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
	<return: #GtMagritteViewModel>
	| aViewModel anObject |
	anObject := self primaryAddressObject.
	aViewModel := GtMagritteViewModel forObject: anObject.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - view model' }
GtMagritteViewModelExamples >> basicAsyncViewModel [
	<gtExample>
	<return: #GtMagritteViewModel>
	| aViewModel |
	aViewModel := GtMagritteViewModel new.

	self assert: aViewModel mementoBlock isNil.
	self assert: aViewModel mementoFuture isNotNil.

	^ aViewModel
]

{ #category : #'examples - dynamic' }
GtMagritteViewModelExamples >> dynamicPersonViewModel [
	<gtExample>
	<return: #GtMagritteViewModel>
	| model description viewModel |
	(model := Dictionary new)
		at: #firstName put: 'John';
		at: #lastName put: 'Doe'.

	(description := MAContainer new)
		add: (MAStringDescription new
				accessor: (MADictionaryAccessor key: #firstName);
				comment: 'First name';
				yourself);
		add: (MAStringDescription new
				accessor: (MADictionaryAccessor key: #lastName);
				comment: 'Last name';
				yourself).

	viewModel := model asGtMagritteViewModelWithDescription: description.

	viewModel
		ignoreImplicitActions;
		addAction: (MAActionDescription new
				priority: 20;
				label: 'Accept & inspect';
				isLabelVisible: false;
				blocIcon: BrGlamorousVectorIcons inspect;
				action: [ :aModel :aButton :aMemento :aDescription | 
					aMemento commit.
					aButton phlow spawnObject: aModel ] asGtMagritteCallback;
				beToolbarAction);
		addAction: (MAActionDescription new
				priority: 25;
				label: 'Cancel';
				isLabelVisible: false;
				blocIcon: BrGlamorousVectorIcons cancel;
				action: [ :aModel :aButton :aMemento :aDescription | aMemento reset ]
						asGtMagritteCallback;
				beEnabledAndChangedAndInactiveOverallStatus;
				beToolbarAction).

	^ viewModel
]

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> elementWithPersonObjectWithTwoAddresses [
	<gtExample>
	<return: #BrFrame>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithPersonObjectWithTwoAddresses.
	anElement := aViewModel asElement.

	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - person with two addresses' }
GtMagritteViewModelExamples >> elementWithPersonObjectWithTwoAddresses_TwiceAsElement [
	<gtExample>
	<return: #BrVerticalPane>
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
	<return: #BrFrame>
	| aViewModel anElement |
	aViewModel := self asyncViewModelWithPrimaryAddress.
	anElement := aViewModel asElement.

	self assert: anElement isNotNil.

	^ anElement
]

{ #category : #'examples - primary address' }
GtMagritteViewModelExamples >> elementWithPrimaryAddress_TwiceAsElement [
	<gtExample>
	<return: #BrVerticalPane>
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

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> personObjectWithTwoAddresses [
	<gtExample>
	<return: #GtMagritteDummyPerson>
	^ GtMagritteModelExamples new personObjectWithTwoAddresses
]

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> primaryAddressObject [
	<gtExample>
	<return: #GtMagritteDummyPostalAddress>
	^ GtMagritteModelExamples new primaryAddressObject
]

{ #category : #'examples - model' }
GtMagritteViewModelExamples >> simpleBaselineObject [
	<gtExample>
	<return: #Dictionary>
	^ GtMagritteModelExamples new simpleBaselineObject
]

{ #category : #'examples - simple directory' }
GtMagritteViewModelExamples >> viewModelWithDirectory [
	<gtExample>
	<return: #GtMagritteViewModel>
	| aViewModel anObject aDescription |
	anObject := GtMagritteModelExamples new simpleDirectoryObject.
	aDescription := GtMagritteModelExamples new simpleDirectoryDescription.
	aViewModel := GtMagritteViewModel forObject: anObject description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]

{ #category : #'examples - simple password' }
GtMagritteViewModelExamples >> viewModelWithPassword [
	<gtExample>
	<return: #GtMagritteViewModel>
	| aViewModel anObject aDescription |
	anObject := GtMagritteModelExamples new simplePasswordObject.
	aDescription := GtMagritteModelExamples new simplePasswordDescription.
	aViewModel := GtMagritteViewModel forObject: anObject description: aDescription.

	self assert: aViewModel mementoFuture isAsyncFuture.

	^ aViewModel
]
