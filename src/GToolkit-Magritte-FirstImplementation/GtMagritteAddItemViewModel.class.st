Class {
	#name : #GtMagritteAddItemViewModel,
	#superclass : #Object,
	#instVars : [
		'callback',
		'stencil',
		'description',
		'memento',
		'items'
	],
	#category : #'GToolkit-Magritte-FirstImplementation'
}

{ #category : #converting }
GtMagritteAddItemViewModel >> asElement [

	^ BrButton new
		  aptitude: BrGlamorousButtonWithIconCircularAptitude;
		  icon: BrGlamorousVectorIcons add;
		  label: 'Add item';
		  beLargeSize;
		  action: [ :anEvent | self onClick: anEvent ];
		  constraintsDo: [ :c | c flow vertical alignCenter ]
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> callback [

	^ callback
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> callback: anObject [

	callback := anObject
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> description [

	^ description
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> items [

	^ items
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> items: anObject [

	items := anObject
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> memento: anObject [

	memento := anObject
]

{ #category : #'private - event handling' }
GtMagritteAddItemViewModel >> onClick: anEvent [

	| aNewItem aNewViewModel anExistingItems aNewItems aNewViewModels |
	self memento ifNil: [ ^ self ].
	self description ifNil: [ ^ self ].
	self items ifNil: [ ^ self ].
	self stencil ifNil: [ ^ self ].

	aNewItem := self stencil create.

	"Update memento"
	anExistingItems := self memento readUsing: self description.
	aNewItems := anExistingItems copyWith: aNewItem.
	self memento write: aNewItems using: self description.

	self callback ifNil: [ ^ self ].

	"Update widget"
	aNewViewModel := aNewItem asGtMagritteViewModel.
	aNewViewModels := self items copyWith: aNewViewModel.

	self items: aNewViewModels.

	self callback cull: (aNewViewModels copyWith: self)
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> stencil [

	^ stencil
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> stencil: aStencil [

	stencil := aStencil asStencil
]
