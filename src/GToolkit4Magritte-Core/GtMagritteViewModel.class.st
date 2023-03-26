Class {
	#name : #GtMagritteViewModel,
	#superclass : #Object,
	#instVars : [
		'cache',
		'mementoBlock',
		'actions',
		'object',
		'onElementCreated'
	],
	#category : #'GToolkit4Magritte-Core-Models'
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
	| aFrame |
	aFrame := BrFrame new.

	aFrame
		fitContent;
		withAsyncFutureDo: [ :anElementFuture | 
			anElementFuture
				whenPending: [ :theContainer | 
					theContainer
						addChild: (BrLabel new
								fitContent;
								aptitude: (BrGlamorousLabelAptitude new
										foreground: BrGlamorousColors disabledButtonTextColor);
								text: 'Preparing...');
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter ] ];
				whenError: [ :theContainer :anError | 
					theContainer userData at: self class gtMementoSymbol put: anError.

					theContainer
						removeChildren;
						addChild: (anError asDebuggableElement
								hFitContentLimited;
								vFitContent);
						constraintsDo: [ :c | 
							c frame horizontal alignCenter.
							c frame vertical alignCenter ] ];
				whenSuccess: [ :theFrame :aMemento | 
					| aStencil aContainer |
					theFrame userData at: self class gtMementoSymbol put: aMemento.

					theFrame removeChildren.

					aStencil := aMemento magritteDescription blocElementContainerStencil
							asStencilBuilder: GtMagritteFormStencilBuilder.

					aContainer := aStencil
							memento: aMemento;
							asElement.

					theFrame addAptitude: (BrLayoutResizerAptitude inherit inherit: aContainer).

					theFrame addChild: aContainer.

					GtMagritteElementBuilder new
						form: theFrame;
						memento: aMemento;
						addButtons: self actions;
						build.
					self onElementCreated cull: theFrame ] ].

	aFrame asyncFuture
		executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #Magritte).
	aFrame asyncFuture future: self mementoFuture.

	^ aFrame
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
	onElementCreated := [ :aFrame | ].
	actions := { }
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

{ #category : #accessing }
GtMagritteViewModel >> object [

	^ object
]

{ #category : #accessing }
GtMagritteViewModel >> onElementCreated [
	"accessor for the callback that is executed once the element is first rendered completely"
	^ onElementCreated
]

{ #category : #accessing }
GtMagritteViewModel >> onElementCreated: aBlock [
	"sets a block to be executed once the view model is first fully rendered as an element. It takes the element as an optional argument. Since the element is created asynchronously, this should be used when access to the element is necessary"
	onElementCreated := aBlock
]
