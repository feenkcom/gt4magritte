Class {
	#name : #GtMagritteAddItemViewModel,
	#superclass : #Object,
	#instVars : [
		'memento',
		'description',
		'stencil'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #converting }
GtMagritteAddItemViewModel >> asElement [

	^ BrButton new
		  aptitude: BrGlamorousButtonWithIconCircularAptitude;
		  icon: BrGlamorousVectorIcons add;
		  label: 'Add item';
		  "beLargeSize;"
		  action: [ :anEvent | self onClick: anEvent ];
		  constraintsDo: [ :c | c flow vertical alignCenter ]
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> description [

	^ description
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> description: anObject [

	description := anObject
]

{ #category : #'api - testing' }
GtMagritteAddItemViewModel >> isForObject [

	^ false
]

{ #category : #'api - testing' }
GtMagritteAddItemViewModel >> isForObject: anObject [

	^ false
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

	| aNewItem anExistingItems aNewItems |
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
GtMagritteAddItemViewModel >> stencil [

	^ stencil
]

{ #category : #accessing }
GtMagritteAddItemViewModel >> stencil: aStencil [

	stencil := aStencil asStencil
]
