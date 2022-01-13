Class {
	#name : #GtMagritteMemento,
	#superclass : #Object,
	#instVars : [
		'memento',
		'announcer',
		'validationPromise',
		'cache',
		'resetPromise',
		'promiseMutex',
		'stateMutex'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #'api - instance creation' }
GtMagritteMemento class >> forMemento: aMemento [

	^ self new memento: aMemento
]

{ #category : #'api - instance creation' }
GtMagritteMemento class >> forObject: anObject description: aDescription [

	| aMemento |
	aMemento := anObject mementoClass
		            model: anObject
		            description: aDescription.

	^ self forMemento: aMemento
]

{ #category : #'api - converting' }
GtMagritteMemento >> asGtMagritteMemento [

	^ self
]

{ #category : #'api - converting' }
GtMagritteMemento >> asGtMagritteViewModel [

	^ GtMagritteViewModel new
		  object: self;
		  description: self memento magritteDescription;
		  memento: self
]

{ #category : #'private - accessing' }
GtMagritteMemento >> cacheAt: aDescription ifAbsentPut: aBlock [

	^ stateMutex critical: [ cache at: aDescription ifAbsentPut: aBlock ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> clearState [

	validationPromise := nil.
	resetPromise := nil
]

{ #category : #'private - actions' }
GtMagritteMemento >> clearStateUsing: aDescription [

	stateMutex critical: [ 
		cache removeKey: aDescription ifAbsent: [ "ignore" ] ].
	self clearState
]

{ #category : #'api - actions' }
GtMagritteMemento >> commit [

	^ self commitPromise
]

{ #category : #'private - accessing' }
GtMagritteMemento >> commitFuture [

	[ self computeCommit ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> commitPromise [

	^ self commitFuture asAsyncStream
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeCommit [

	stateMutex critical: [ self memento commit ]
]

{ #category : #'private - accessing' }
GtMagritteMemento >> computeReadUsing: aDescription [

	| aValue |
	[ aValue := self memento readUsing: aDescription ]
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
	stateMutex critical: [ 
		"cache locally old values"
		allValues := cache copy.

		"reset memento"
		[ self memento reset ]
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

	"return either about reset failure or success"
	^ aResult ifNil: [ GtMagritteResetSuccess new memento: self ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeValidation [

	| aResult |
	stateMutex critical: [ 
		[ 
		self memento validate.
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
GtMagritteMemento >> computeWriteOld: anOldValue new: aNewValue using: aDescription [

	| aResult |
	anOldValue = aNewValue ifTrue: [ 
		^ GtMagritteWriteUnchanged new
			  memento: self;
			  description: aDescription;
			  value: anOldValue ].

	stateMutex critical: [ 
		[ self memento write: aNewValue using: aDescription ]
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
		cache at: aDescription put: aResult asAsyncPromise ].

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
	self memento ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Memento';
		  priority: 1;
		  object: [ self memento ];
		  view: #gtGtMagritteFor:context:
]

{ #category : #initialization }
GtMagritteMemento >> initialize [

	super initialize.

	promiseMutex := Mutex new.
	stateMutex := Mutex new.
	cache := SmallDictionary new.
]

{ #category : #'private - accessing' }
GtMagritteMemento >> memento [

	^ memento
]

{ #category : #'api - initialization' }
GtMagritteMemento >> memento: aMemento [

	self
		assert: [ memento isNil ]
		description: [ 'Memento can be initialized only once' ].

	memento := aMemento
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
GtMagritteMemento >> notifyValueChanged: anObject using: aDescription [

	announcer ifNil: [ ^ self ].

	announcer announce: (GtMagritteModelValueChangedAnnouncement new
			 memento: self;
			 value: anObject;
			 description: aDescription)
]

{ #category : #printing }
GtMagritteMemento >> printOn: aStream [

	super printOn: aStream.

	self memento ifNil: [ ^ self ].

	aStream
		nextPut: $(;
		print: self memento model;
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

{ #category : #'private - accessing' }
GtMagritteMemento >> validationFuture [

	^ [ self computeValidation ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> validationPromise [

	^ promiseMutex critical: [ 
		  validationPromise ifNil: [ 
			  validationPromise := self validationFuture asAsyncPromise ] ]
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
