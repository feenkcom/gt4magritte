Class {
	#name : #GtMagritteViewModel,
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
GtMagritteViewModel class >> forObject: anObject [

	^ self new
		  mementoBlock: [ GtMagritteMemento model: anObject ]
		  object: anObject
]

{ #category : #'api - instance creation' }
GtMagritteViewModel class >> forObject: anObject description: aDescriptionOrBlock [

	^ self new
		  mementoBlock: [ 
			  GtMagritteMemento
				  model: anObject
				  description: aDescriptionOrBlock value asContainer ]
		  object: anObject
]

{ #category : #constants }
GtMagritteViewModel class >> gtMementoSymbol [

	^ #gtmemento
]

{ #category : #accessing }
GtMagritteViewModel >> actions [

	^ actions
]

{ #category : #accessing }
GtMagritteViewModel >> actions: anObject [

	actions := anObject
]

{ #category : #'api - initialization' }
GtMagritteViewModel >> addButton: aButtonDefinition [

	self actions: (self actions copyWith: aButtonDefinition)
]

{ #category : #'api - initialization' }
GtMagritteViewModel >> addButtons: aCollection [

	self actions: (self actions copyWithAll: aCollection)
]

{ #category : #'api - converting' }
GtMagritteViewModel >> asElement [

	| aContainer |
	aContainer := BrHorizontalGrid new.

	aContainer magritte
		beLabelContainer;
		beFieldContainer.

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
					theContainer userData at: self class gtMementoSymbol put: anError.

					theContainer
						removeChildren;
						addChild: (anError asDebuggableElement
								 hFitContentLimited;
								 vFitContent) ];
				whenSuccess: [ :theContainer :aMemento | 
					theContainer userData
						at: self class gtMementoSymbol
						put: aMemento.

					theContainer removeChildren.
					GtMagritteElementBuilder new
						form: theContainer;
						memento: aMemento;
						addButtons;
						addButtons: self actions;
						build ] ].

	aContainer asyncFuture future: self mementoFuture.

	^ aContainer
]

{ #category : #'api - converting' }
GtMagritteViewModel >> asGtMagritteViewModel [

	^ self
]

{ #category : #'gt - extensions' }
GtMagritteViewModel >> gtLiveFor: aView [

	<gtView>
	self mementoBlock ifNil: [ ^ aView empty ].

	^ aView explicit
		  title: 'Live';
		  priority: 1;
		  stencil: [ self ];
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Memento'
		  tooltip: 'Inspect Memento'
		  action: [ :aButton :aTab | 
			  aTab viewContentElement
				  allChildrenBreadthFirstDetect: [ :anElement | 
					  anElement userData includesKey:
							  GtMagritteViewModel gtMementoSymbol ]
				  ifFound: [ :anElement | 
					  aButton phlow spawnObject:
							  (anElement userData at: GtMagritteViewModel gtMementoSymbol) ] ]
]

{ #category : #initialization }
GtMagritteViewModel >> initialize [

	super initialize.

	cache := AsyncFutureCache new.
	actions := #(  )
]

{ #category : #'api - testing' }
GtMagritteViewModel >> isForObject: anObject [

	^ object == anObject
]

{ #category : #'private - accessing' }
GtMagritteViewModel >> mementoBlock [

	^ mementoBlock
]

{ #category : #'api - initialization' }
GtMagritteViewModel >> mementoBlock: aBlock object: anObject [

	self
		assert: [ mementoBlock isNil ]
		description: [ 'Memento block can be initialized only once' ].

	mementoBlock := aBlock.
	object := anObject
]

{ #category : #accessing }
GtMagritteViewModel >> mementoFuture [

	^ AsyncCachedFuture
		  forFuture: mementoBlock asAsyncFuture
		  cache: cache
]
