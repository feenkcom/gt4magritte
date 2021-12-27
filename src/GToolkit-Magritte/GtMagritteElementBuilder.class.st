Class {
	#name : #GtMagritteElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'form',
		'presenter',
		'object',
		'objectDescription'
	],
	#category : #'GToolkit-Magritte-Core'
}

{ #category : #converting }
GtMagritteElementBuilder >> asElement [

	<return: #BlElement>
	| aForm |
	self
		assert: [ self objectDescription isNotNil ]
		description: [ 'Magritte description must be defined' ].

	[ 
	self visit: self objectDescription.
	aForm := self form ] ensure: [ form := nil ].
	
	^ aForm
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> createFormElement [

	^ BrHorizontalGrid new
		  columnCount: 2;
		  cellSpacing: 0;
		  padding: (BlInsets all: self defaultSpacing);
		  in: [ :theElement | 
			  theElement userData at: #magrittePresenter put: self presenter ];
		  hMatchParent;
		  vFitContent
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> createPresenter [

	^ GtMagritteContainerPresenter memento: (self object mementoClass
			   model: self object
			   description: self objectDescription)
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> defaultSpacing [

	^ GtMagritteBuilderUtility defaultSpaceNumber
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> form [

	^ form ifNil: [ form := self createFormElement ]
]

{ #category : #'gt - extensions' }
GtMagritteElementBuilder >> gtLiveFor: aView [

	<gtView>
	self objectDescription ifNil: [ ^ aView empty ].

	^ aView explicit
		  title: 'Live';
		  priority: 1;
		  stencil: [ self ]
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> memento [

	^ self presenter memento
]

{ #category : #accessing }
GtMagritteElementBuilder >> object [

	^ object
]

{ #category : #accessing }
GtMagritteElementBuilder >> object: anObject [

	object := anObject.
	presenter := nil.
]

{ #category : #accessing }
GtMagritteElementBuilder >> objectDescription [

	^ objectDescription
]

{ #category : #accessing }
GtMagritteElementBuilder >> objectDescription: anObject [

	objectDescription := anObject.
	presenter := nil
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> presenter [

	^ presenter ifNil: [ presenter := self createPresenter ]
]
