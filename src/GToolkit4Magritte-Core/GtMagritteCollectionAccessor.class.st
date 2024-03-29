"
I know how to add and remove items into/from a collection.
"
Class {
	#name : #GtMagritteCollectionAccessor,
	#superclass : #MAAccessor,
	#instVars : [
		'removeOne',
		'addOne',
		'collection',
		'model'
	],
	#category : #'GToolkit4Magritte-Core-Accessors'
}

{ #category : #testing }
GtMagritteCollectionAccessor class >> isAbstract [

	^ false
]

{ #category : #comparing }
GtMagritteCollectionAccessor >> = anObject [
	^ super = anObject
		and: [ self model = anObject model
		and: [ self collection = anObject collection
		and: [ self addOne = anObject addOne
		and: [ self removeOne = anObject removeOne ] ] ] ]
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> addOne [

	^ addOne
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> addOne: aBlock [

	"Set a block that knows how to add one item into a collection.
	The block receives two arguments: [ :aModel :anItem | ], where 
	  - aModel is a model that holds the collection, and 
	  - anItem is an object to add into the model collection"

	addOne := aBlock
]

{ #category : #testing }
GtMagritteCollectionAccessor >> canRead: aModel [

	^ (self model canRead: aModel) and: [ 
		  self collection canRead: (self model read: aModel) ]
]

{ #category : #testing }
GtMagritteCollectionAccessor >> canWrite: aModel [

	^ (self canRead: aModel) and: [ 
		  self addOne notNil and: [ self removeOne notNil ] ]
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> collection [

	^ collection
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> collection: anAccessor [

	"Set accessor to a collection that holds items."

	collection := anAccessor asAccessor
]

{ #category : #comparing }
GtMagritteCollectionAccessor >> hash [
	^ (((super hash 
		bitXor: self model hash)
		bitXor: self collection hash)
		bitXor: self addOne hash)
		bitXor: self removeOne hash
]

{ #category : #initialization }
GtMagritteCollectionAccessor >> initialize [

	super initialize.

	model := #yourself asAccessor.
	collection := nil asAccessor.
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> model [

	^ model
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> model: anAccessor [

	"Set accessor to a model that knows how to add and remove collection items"

	model := anAccessor asAccessor
]

{ #category : #'meta-object-protocol' }
GtMagritteCollectionAccessor >> read: aModel [

	^ self collection read: (self model read: aModel)
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> removeOne [

	^ removeOne
]

{ #category : #accessing }
GtMagritteCollectionAccessor >> removeOne: aBlock [

	"Set a block that knows how to remove one item from a collection.
	The block receives two arguments: [ :aModel :anItem | ], where 
	  - aModel is a model that holds the collection, and 
	  - anItem is an object to remove to the model collection"

	removeOne := aBlock
]

{ #category : #writing }
GtMagritteCollectionAccessor >> write: aNewCollection to: aModel [

	| aHolder aCurrentCollection toAdd toRemove |
	aHolder := self model read: aModel.
	aCurrentCollection := self collection read: aHolder.

	toAdd := aNewCollection reject: [ :eachItem | 
		         aCurrentCollection identityIncludes: eachItem ].
	toRemove := aCurrentCollection reject: [ :eachItem | 
		            aNewCollection identityIncludes: eachItem ].

	toRemove do: [ :eachItem | 
		self removeOne value: aHolder value: eachItem ].
	toAdd do: [ :eachItem | self addOne value: aHolder value: eachItem ]
]
