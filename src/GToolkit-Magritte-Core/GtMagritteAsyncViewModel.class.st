Class {
	#name : #GtMagritteAsyncViewModel,
	#superclass : #Object,
	#instVars : [
		'cache',
		'mementoBlock',
		'actions',
		'object'
	],
	#category : #'GToolkit-Magritte-Core-Models'
}

{ #category : #'api - instance creation' }
GtMagritteAsyncViewModel class >> forObject: anObject [

	^ self new
		  mementoBlock: [ GtMagritteAsyncMemento model: anObject ]
		  object: anObject
]

{ #category : #'api - instance creation' }
GtMagritteAsyncViewModel class >> forObject: anObject description: aDescription [

	^ self new
		  mementoBlock: [ 
		  	GtMagritteAsyncMemento model: anObject description: aDescription ]
		  object: anObject
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> actions [

	^ actions
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> actions: anObject [

	actions := anObject
]

{ #category : #'api - initialization' }
GtMagritteAsyncViewModel >> addButton: aButtonDefinition [

	self actions: (self actions copyWith: aButtonDefinition)
]

{ #category : #'api - initialization' }
GtMagritteAsyncViewModel >> addButtons: aCollection [

	self actions: (self actions copyWithAll: aCollection)
]

{ #category : #'api - converting' }
GtMagritteAsyncViewModel >> asElement [

	| aContainer |
	aContainer := BrHorizontalGrid new.

	aContainer
		cellSpacing: 0;
		columnCount: 2;
		fitContent;
		withAsyncFutureDo: [ :anElementFuture | 
			anElementFuture
				whenPending: [ :theContainer | 
					theContainer addChild: (BrLabel new
								 aptitude: (BrGlamorousLabelAptitude new foreground:
											  BrGlamorousColors disabledButtonTextColor);
								 text: 'Preparing...') ];
				whenError: [ :theContainer :anError | 
					theContainer userData at: #gtmemento put: anError.

					theContainer
						removeChildren;
						addChild: anError asDebuggableElement hFitContentLimited;
						vFitContent ];
				whenSuccess: [ :theContainer :aMemento | 
					theContainer userData at: #gtmemento put: aMemento.

					theContainer removeChildren.
					GtMagritteAsyncElementBuilder new
						form: theContainer;
						memento: aMemento;
						addButtons;
						addButtons: self actions;
						build ] ].

	aContainer asyncFuture future: self mementoFuture.

	^ aContainer
]

{ #category : #'api - converting' }
GtMagritteAsyncViewModel >> asGtMagritteAsyncViewModel [

	^ self
]

{ #category : #initialization }
GtMagritteAsyncViewModel >> initialize [

	super initialize.

	cache := AsyncFutureCache new.
	actions := #(  )
]

{ #category : #'api - testing' }
GtMagritteAsyncViewModel >> isForObject: anObject [

	^ object == anObject
]

{ #category : #'api - initialization' }
GtMagritteAsyncViewModel >> mementoBlock: aBlock object: anObject [

	self
		assert: [ mementoBlock isNil ]
		description: [ 'Memento block can be initialized only once' ].

	mementoBlock := aBlock.
	object := anObject
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> mementoFuture [

	^ AsyncCachedFuture
		  forFuture: mementoBlock asAsyncFuture
		  cache: cache
]
