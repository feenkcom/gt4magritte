Class {
	#name : #GtMagritteAsyncViewModel,
	#superclass : #Object,
	#instVars : [
		'cache',
		'mementoBlock',
		'actions'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #'api - instance creation' }
GtMagritteAsyncViewModel class >> forObject: anObject [

	^ self new mementoBlock: [ GtMagritteAsyncMemento model: anObject ]
]

{ #category : #'api - instance creation' }
GtMagritteAsyncViewModel class >> forObject: anObject description: aDescription [

	^ self new mementoBlock: [ 
		  GtMagritteAsyncMemento model: anObject description: aDescription ]
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

{ #category : #accessing }
GtMagritteAsyncViewModel >> cache [

	^ cache
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> cache: anObject [

	cache := anObject
]

{ #category : #initialization }
GtMagritteAsyncViewModel >> initialize [

	super initialize.

	cache := AsyncFutureCache new.
	actions := #(  )
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> mementoBlock [

	^ mementoBlock
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> mementoBlock: anObject [

	mementoBlock := anObject
]

{ #category : #accessing }
GtMagritteAsyncViewModel >> mementoFuture [

	^ AsyncCachedFuture
		  forFuture: self mementoBlock asAsyncFuture
		  cache: cache
]
