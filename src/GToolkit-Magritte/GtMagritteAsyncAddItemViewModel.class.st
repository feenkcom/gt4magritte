Class {
	#name : #GtMagritteAsyncAddItemViewModel,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'stencil'
	],
	#category : #'GToolkit-Magritte-Support'
}

{ #category : #converting }
GtMagritteAsyncAddItemViewModel >> asElement [

	^ BrButton new
		  aptitude: BrGlamorousButtonWithIconCircularAptitude;
		  icon: BrGlamorousVectorIcons add;
		  label: 'Add item';
		  beLargeSize;
		  action: [ :anEvent | self onClick: anEvent ];
		  constraintsDo: [ :c | c flow vertical alignCenter ]
]

{ #category : #accessing }
GtMagritteAsyncAddItemViewModel >> description [

	^ description
]

{ #category : #accessing }
GtMagritteAsyncAddItemViewModel >> description: anObject [

	description := anObject
]

{ #category : #'api - testing' }
GtMagritteAsyncAddItemViewModel >> isForObject: anObject [

	^ false
]

{ #category : #accessing }
GtMagritteAsyncAddItemViewModel >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteAsyncAddItemViewModel >> memento: anObject [

	memento := anObject
]

{ #category : #'private - event handling' }
GtMagritteAsyncAddItemViewModel >> onClick: anEvent [

	| aNewItem aNewViewModel anExistingItems aNewItems aNewViewModels |
	self memento ifNil: [ ^ self ].
	self description ifNil: [ ^ self ].
	self stencil ifNil: [ ^ self ].

	aNewItem := self stencil create.

	"Update memento"
	anExistingItems := self memento readUsing: self description.
	aNewItems := anExistingItems copyWith: aNewItem.
	self memento write: aNewItems using: self description
]

{ #category : #accessing }
GtMagritteAsyncAddItemViewModel >> stencil [

	^ stencil
]

{ #category : #accessing }
GtMagritteAsyncAddItemViewModel >> stencil: aStencil [

	stencil := aStencil asStencil
]
