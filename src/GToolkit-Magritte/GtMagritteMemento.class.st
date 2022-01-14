Class {
	#name : #GtMagritteMemento,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'validationPromise',
		'resetPromise',
		'promiseMutex',
		'stateMutex',
		'commitPromise',
		'readCache',
		'validationCache',
		'mementoPromise',
		'memento'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #'api - instance creation' }
GtMagritteMemento class >> forMemento: aMemento [

	| aPromise |
	aPromise := aMemento asAsyncPromise.

	^ self new mementoPromise: aPromise
]

{ #category : #'api - instance creation' }
GtMagritteMemento class >> forObject: anObject description: aDescription [

	| aPromise |
	aPromise := [ 
	            GtMagritteBuilderUtility
		            computeMementoForObject: anObject
		            description: aDescription ] asAsyncPromise.

	^ self new mementoPromise: aPromise
]

{ #category : #'api - converting' }
GtMagritteMemento >> asGtMagritteMemento [

	^ self
]

{ #category : #'api - converting' }
GtMagritteMemento >> asGtMagritteViewModel [

	^ GtMagritteViewModel new
		  memento: self;
		  object: self;
		  description: self magritteDescription
]

{ #category : #'private - accessing' }
GtMagritteMemento >> cacheAt: aDescription ifAbsentPut: aBlock [

	^ stateMutex critical: [ readCache at: aDescription ifAbsentPut: aBlock ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> clearState [

	validationPromise := nil.
	resetPromise := nil.
	commitPromise := nil.
]

{ #category : #'private - actions' }
GtMagritteMemento >> clearStateUsing: aDescription [

	stateMutex critical: [ 
		readCache removeKey: aDescription ifAbsent: [ "ignore" ].
		validationCache removeKey: aDescription ifAbsent: [ "ignore" ] ].
	self clearState
]

{ #category : #'api - actions' }
GtMagritteMemento >> commit [

	^ self commitPromise
]

{ #category : #'private - accessing' }
GtMagritteMemento >> commitFuture [

	^ [ self computeCommit ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> commitPromise [

	^ promiseMutex critical: [ 
		  commitPromise ifNil: [ 
			  commitPromise := self commitFuture asAsyncPromise ] ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeCommit [

	stateMutex critical: [ 
		[ self mementoDo: [ :aMemento | aMemento commit ] ]
			on: Error
			do: [ :anError | 
				^ GtMagritteCommitError new
					  memento: self;
					  exception: anError ] ].

	^ GtMagritteCommitSuccess new memento: self
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeReadUsing: aDescription [

	| aValue |
	[ 
	stateMutex critical: [ 
		self mementoDo: [ :aMemento | 
			aValue := aMemento readUsing: aDescription ] ] ]
		on: Error
		do: [ :anError | 
			^ GtMagritteReadFailure new
				  memento: self;
				  description: aDescription;
				  exception: anError ].

	^ GtMagritteReadSuccess new
		  memento: self;
		  description: aDescription;
		  value: aValue
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeReset [

	| allValues aResult |
	stateMutex critical: [ "cache locally old values"
		allValues := readCache copy.

		"reset memento"
		[ self mementoDo: [ :aMemento | aMemento reset ] ]
			on: Error
			do: [ :anError | 
			aResult := GtMagritteResetFailure new exception: anError ].


		"clear cached values"
		allValues keysDo: [ :aDescription | 
			self clearStateUsing: aDescription ] ].

	"notify on value changes 
	- we notify only about previously cached values
	  as they are the only one users were previously interested"
	allValues keysAndValuesDo: [ :aDescription :anOldPromise | 
		anOldPromise asyncThen: [ :anOldResult | 
			| aNewPromise |
			aNewPromise := self readPromiseUsing: aDescription.
			aNewPromise then: [ :aNewResult | 
				(aNewResult isSuccess and: [ 
					 (anOldResult isSuccess and: [ 
						  anOldResult value ~= aNewResult value ]) or: [ 
						 anOldResult isSuccess not ] ]) ifTrue: [ 
					self notifyValueChanged: aNewResult value using: aDescription ] ] ] ].

	"return either reset failure or success result"
	^ aResult ifNil: [ GtMagritteResetSuccess new memento: self ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeValidation [

	| aResult |
	stateMutex critical: [ 
		[ 
		self mementoDo: [ :aMemento | aMemento validate ].
		aResult := GtMagritteValidationSuccess new memento: self ]
			on: MAValidationError
			do: [ :anError | 
				aResult := GtMagritteValidationFailure new
					           memento: self;
					           exception: anError ] ].

	self notifyValidationChanged: aResult.

	^ aResult
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeValidation: anObject using: aDescription [

	| aResult |
	stateMutex critical: [ 
		[ 
		aDescription validate: anObject.
		aResult := GtMagritteDescriptionValidationSuccess new
			           memento: self;
			           description: aDescription;
			           value: anObject ]
			on: MAValidationError
			do: [ :anError | 
				aResult := GtMagritteDescriptionValidationFailure new
					           memento: self;
					           description: aDescription;
					           value: anObject;
					           exception: anError ] ].

	self notifyValidationChanged: aResult using: aDescription.

	^ aResult
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeWriteOld: anOldValue new: aNewValue using: aDescription [

	| aResult |
	anOldValue = aNewValue ifTrue: [ 
		^ GtMagritteWriteUnchanged new
			  memento: self;
			  description: aDescription;
			  value: anOldValue ].

	stateMutex critical: [ 
		[ 
		self mementoDo: [ :aMemento | 
			aMemento write: aNewValue using: aDescription ] ]
			on: Error
			do: [ :anError | 
				self clearStateUsing: aDescription.
				^ GtMagritteWriteFailure new
					  memento: self;
					  description: aDescription;
					  oldValue: anOldValue;
					  newValue: aNewValue;
					  exception: anError ].
		self clearStateUsing: aDescription.
		aResult := GtMagritteWriteSuccess new
			           memento: self;
			           description: aDescription;
			           value: aNewValue.
		readCache at: aDescription put: aResult asAsyncPromise ].

	(self readPromiseUsing: aDescription) asyncThen: [ 
		self notifyValueChanged: aNewValue using: aDescription ].

	^ aResult
]

{ #category : #'private - initialization' }
GtMagritteMemento >> ensureAnnouncer [

	announcer ifNotNil: [ ^ self ].

	announcer := Announcer new
]

{ #category : #'gt - extensions' }
GtMagritteMemento >> gtGtMagritteFor: aView context: aContext [

	<gtView>
	self mementoPromise ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Memento';
		  priority: 1;
		  object: [ 
			  | aMemento |
			  aMemento := nil.
			  self mementoDo: [ :theMemento | aMemento := theMemento ].
			  aMemento ];
		  view: #gtGtMagritteFor:context:
]

{ #category : #initialization }
GtMagritteMemento >> initialize [

	super initialize.

	promiseMutex := Mutex new.
	stateMutex := Mutex new.
	readCache := SmallDictionary new.
	validationCache := SmallDictionary new.
]

{ #category : #'api - accessing' }
GtMagritteMemento >> magritteDescription [

	self mementoDo: [ :aMemento | ^ aMemento magritteDescription ].

	^ nil
]

{ #category : #'private - accessing' }
GtMagritteMemento >> mementoDo: aBlock [

	"I should be used only inside of other future computations.
	Block is executed inside of a current process that calls this method."

	| aSemaphore |
	memento ifNotNil: [ :aMemento | 
		aBlock cull: aMemento.
		^ self ].

	aSemaphore := Semaphore new.
	self mementoPromise
		then: [ :aResult | 
			aResult isSuccess ifTrue: [ 
				stateMutex critical: [ 
					memento ifNil: [ memento := aResult memento ] ] ].
			aSemaphore signal ]
		otherwise: [ :anError | aSemaphore signal ].

	aSemaphore wait.

	memento ifNotNil: [ :aMemento | aBlock cull: aMemento ]
]

{ #category : #'private - accessing' }
GtMagritteMemento >> mementoPromise [

	^ mementoPromise
]

{ #category : #'api - initialization' }
GtMagritteMemento >> mementoPromise: aPromise [

	self
		assert: [ mementoPromise isNil ]
		description: [ 'Memento promise can be initialized only once' ].

	mementoPromise := aPromise
]

{ #category : #'api - accessing' }
GtMagritteMemento >> model [

	self mementoDo: [ :aMemento | ^ aMemento model ].

	^ nil
]

{ #category : #'private - notifying' }
GtMagritteMemento >> notifyValidationChanged: aResult [

	announcer ifNil: [ ^ self ].

	self validationPromise then: [ :theResult | 
		announcer announce:
			(GtMagritteMementoValidationChangedAnnouncement new
				 memento: self;
				 result: theResult) ]
]

{ #category : #'private - notifying' }
GtMagritteMemento >> notifyValidationChanged: aResult using: aDescription [

	| aPromise |
	announcer ifNil: [ ^ self ].

	aPromise := self validationPromiseUsing: aDescription.
	aPromise then: [ :theResult | 
		announcer announce:
			(GtMagritteMementoDescriptionValidationChangedAnnouncement new
				 memento: self;
				 description: aDescription;
				 result: theResult) ]
]

{ #category : #'private - notifying' }
GtMagritteMemento >> notifyValueChanged: aValue using: aDescription [

	announcer ifNil: [ ^ self ].

	announcer announce: (GtMagritteModelValueChangedAnnouncement new
			 memento: self;
			 value: aValue;
			 description: aDescription)
]

{ #category : #printing }
GtMagritteMemento >> printOn: aStream [

	| aModel |
	super printOn: aStream.

	self mementoPromise ifNil: [ ^ self ].

	aModel := nil.
	self mementoDo: [ :aMemento | aModel := aMemento model ].

	aStream
		nextPut: $(;
		print: aModel;
		nextPut: $)
]

{ #category : #'private - accessing' }
GtMagritteMemento >> readFutureUsing: aDescription [

	^ [ self computeReadUsing: aDescription ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> readPromiseUsing: aDescription [

	^ promiseMutex critical: [ 
		  self
			  cacheAt: aDescription
			  ifAbsentPut: [ 
			  	(self readFutureUsing: aDescription) asAsyncPromise ] ]
]

{ #category : #'api - actions' }
GtMagritteMemento >> readUsing: aDescription [

	^ self readPromiseUsing: aDescription
]

{ #category : #'api - actions' }
GtMagritteMemento >> reset [

	^ self resetPromise
]

{ #category : #'private - accessing' }
GtMagritteMemento >> resetFuture [

	^ [ self computeReset ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> resetPromise [

	^ promiseMutex critical: [ 
		  resetPromise ifNil: [ 
			  resetPromise := self resetFuture asAsyncPromise ] ]
]

{ #category : #'api - subscriptions' }
GtMagritteMemento >> unsubscribe: aSubscriber [

	announcer ifNil: [ ^ self ].

	announcer unsubscribe: aSubscriber
]

{ #category : #'api - actions' }
GtMagritteMemento >> validate [

	^ self validationPromise
]

{ #category : #'api - actions' }
GtMagritteMemento >> validateUsing: aDescription [

	^ self validationPromiseUsing: aDescription
]

{ #category : #'private - accessing' }
GtMagritteMemento >> validationCacheAt: aDescription ifAbsentPut: aBlock [

	^ stateMutex critical: [ 
		  validationCache at: aDescription ifAbsentPut: aBlock ]
]

{ #category : #'private - accessing' }
GtMagritteMemento >> validationFuture [

	^ [ self computeValidation ] asAsyncFuture
]

{ #category : #'private - accessing' }
GtMagritteMemento >> validationFuture: anObject using: aDescription [

	^ [ self computeValidation: anObject using: aDescription ]
		  asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> validationPromise [

	^ promiseMutex critical: [ 
		  validationPromise ifNil: [ 
			  validationPromise := self validationFuture asAsyncPromise ] ]
]

{ #category : #'api - actions' }
GtMagritteMemento >> validationPromiseUsing: aDescription [

	^ promiseMutex critical: [ 
		  self validationCacheAt: aDescription ifAbsentPut: [ 
			  (self readPromiseUsing: aDescription) then: [ :aResult | 
				  aResult isSuccess
					  ifTrue: [ 
						  (self validationFuture: aResult value using: aDescription)
							  asAsyncPromise ]
					  ifFalse: [ aResult asAsyncPromise ] ] ] ]
]

{ #category : #'api - subscriptions' }
GtMagritteMemento >> when: anAnnouncement send: aMessage to: aReceiver [

	self ensureAnnouncer.

	^ announcer weak when: anAnnouncement send: aMessage to: aReceiver
]

{ #category : #'api - actions' }
GtMagritteMemento >> write: anObject using: aDescription [

	^ self writePromise: anObject using: aDescription
]

{ #category : #'private - accessing' }
GtMagritteMemento >> writeFutureOld: anOldValue new: aNewValue using: aDescription [

	^ [ 
	  self computeWriteOld: anOldValue new: aNewValue using: aDescription ]
		  asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> writePromise: anObject using: aDescription [

	^ promiseMutex critical: [ 
		  (self readPromiseUsing: aDescription) then: [ :aResult | 
			  aResult isSuccess
				  ifTrue: [ 
					  (self
						   writeFutureOld: aResult value
						   new: anObject
						   using: aDescription) asAsyncPromise ]
				  ifFalse: [ aResult asAsyncPromise ] ] ]
]
