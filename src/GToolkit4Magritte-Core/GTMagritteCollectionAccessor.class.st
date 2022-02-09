"
I know how to add and remove items into/from a collection.
"
Class {
	#name : #GTMagritteCollectionAccessor,
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
GTMagritteCollectionAccessor class >> isAbstract [

	^ false
]

{ #category : #comparing }
GTMagritteCollectionAccessor >> = anObject [
	^ super = anObject
		and: [ self model = anObject model
		and: [ self collection = anObject collection
		and: [ self addOne = anObject addOne
		and: [ self removeOne = anObject removeOne ] ] ] ]
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> addOne [

	^ addOne
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> addOne: aBlock [

	"Set a block that knows how to add one item into a collection.
	The block receives two arguments: [ :aModel :anItem | ], where 
	  - aModel is a model that holds the collection, and 
	  - anItem is an object to add into the model collection"

	addOne := aBlock
]

{ #category : #testing }
GTMagritteCollectionAccessor >> canRead: aModel [

	^ (self model canRead: aModel) and: [ 
		  self collection canRead: (self model read: aModel) ]
]

{ #category : #testing }
GTMagritteCollectionAccessor >> canWrite: aModel [

	^ (self canRead: aModel) and: [ 
		  self addOne notNil and: [ self removeOne notNil ] ]
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> collection [

	^ collection
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> collection: anAccessor [

	"Set accessor to a collection that holds items."

	collection := anAccessor asAccessor
]

{ #category : #comparing }
GTMagritteCollectionAccessor >> hash [
	^ (((super hash 
		bitXor: self model hash)
		bitXor: self collection hash)
		bitXor: self addOne hash)
		bitXor: self removeOne hash
]

{ #category : #initialization }
GTMagritteCollectionAccessor >> initialize [

	super initialize.

	model := #yourself asAccessor.
	collection := nil asAccessor.
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> model [

	^ model
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> model: anAccessor [

	"Set accessor to a model that knows how to add and remove collection items"

	model := anAccessor asAccessor
]

{ #category : #'meta-object-protocol' }
GTMagritteCollectionAccessor >> read: aModel [

	^ self collection read: (self model read: aModel)
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> removeOne [

	^ removeOne
]

{ #category : #accessing }
GTMagritteCollectionAccessor >> removeOne: aBlock [

	"Set a block that knows how to remove one item from a collection.
	The block receives two arguments: [ :aModel :anItem | ], where 
	  - aModel is a model that holds the collection, and 
	  - anItem is an object to remove to the model collection"

	removeOne := aBlock
]

{ #category : #writing }
GTMagritteCollectionAccessor >> write: aNewCollection to: aModel [

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
