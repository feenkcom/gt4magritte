Class {
	#name : #GtMagritteElementBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'form',
		'presenter',
		'object',
		'objectDescription',
		'memento'
	],
	#category : #'GToolkit-Magritte-Builders'
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
	aForm := self form.
	aForm userData at: #magrittePresenter put: self presenter ] ensure: [ 
		form := nil.
		presenter := nil ].

	^ aForm
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> createFormElement [

	^ BrHorizontalGrid new
		  columnCount: 2;
		  cellSpacing: 0;
		  padding: (BlInsets all: self defaultSpacing);
		  vFitContent;
		  hFitContent
]

{ #category : #'private - building' }
GtMagritteElementBuilder >> createMemento [

	^ self object mementoClass
		  model: self object
		  description: self objectDescription
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> createPresenter [

	^ GtMagritteContainerPresenter memento: self memento
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

	^ memento ifNil: [ memento := self createMemento ]
]

{ #category : #accessing }
GtMagritteElementBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #accessing }
GtMagritteElementBuilder >> object [

	^ object
]

{ #category : #accessing }
GtMagritteElementBuilder >> object: anObject [

	object := anObject.
	presenter := nil.
	memento := nil.
]

{ #category : #accessing }
GtMagritteElementBuilder >> objectDescription [

	^ objectDescription
]

{ #category : #accessing }
GtMagritteElementBuilder >> objectDescription: anObject [

	objectDescription := anObject.
	presenter := nil.
	memento := nil.
]

{ #category : #'private - accessing' }
GtMagritteElementBuilder >> presenter [

	^ presenter ifNil: [ presenter := self createPresenter ]
]
