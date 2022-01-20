Class {
	#name : #GtMagritteAsyncViewModel,
	#superclass : #Object,
	#instVars : [
		'mementoFuture'
	],
	#category : #'GToolkit-Magritte-New-Models'
}

{ #category : #'api - instance creation' }
GtMagritteAsyncViewModel class >> forObject: anObject [

	^ self new mementoFuture:
		  [ GtMagritteAsyncMemento model: anObject ] asAsyncFuture
]

{ #category : #'api - instance creation' }
GtMagritteAsyncViewModel class >> forObject: anObject description: aDescription [

	^ self new mementoFuture:
		  [ 
		  GtMagritteAsyncMemento model: anObject description: aDescription ]
			  asAsyncFuture
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
						build ] ].

	aContainer asyncFuture future: self mementoFuture.

	^ aContainer
]

{ #category : #'private - accessing' }
GtMagritteAsyncViewModel >> mementoFuture [

	^ mementoFuture
]

{ #category : #'api - initialization' }
GtMagritteAsyncViewModel >> mementoFuture: anAsyncFuture [

	self
		assert: [ mementoFuture isNil ]
		description: [ 'Memento future can be initialized only once' ].

	mementoFuture := anAsyncFuture
]
