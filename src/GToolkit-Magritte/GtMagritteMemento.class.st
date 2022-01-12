Class {
	#name : #GtMagritteMemento,
	#superclass : #Object,
	#instVars : [
		'memento',
		'announcer',
		'mutex',
		'validationPromise',
		'cache'
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

{ #category : #'private - actions' }
GtMagritteMemento >> clearState [

	validationPromise := nil
]

{ #category : #'private - actions' }
GtMagritteMemento >> clearStateUsing: aDescription [

	cache removeKey: aDescription ifAbsent: [ "ignore" ].
	self clearState.
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

	mutex critical: [ self memento commit ]
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

	mutex critical: [ 
		self memento reset.
		self clearState ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeValidation [

	| aResult |
	mutex critical: [ 
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

	anOldValue = aNewValue ifTrue: [ 
		^ GtMagritteWriteUnchanged new
			  memento: self;
			  description: aDescription;
			  value: anOldValue ].

	mutex critical: [ 
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
		self clearStateUsing: aDescription ].
		
	self notifyValueChanged: aNewValue using: aDescription.

	^ GtMagritteWriteSuccess new
		  memento: self;
		  description: aDescription;
		  value: aNewValue
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

	mutex := Mutex new.
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
				 result: aResult) ]
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

	^ mutex critical: [ 
		  cache
			  at: aDescription
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

	^ self resetFuture asAsyncPromise
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

	^ mutex critical: [ 
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

	^ mutex critical: [ 
		  (self readPromiseUsing: aDescription) then: [ :aResult | 
			  aResult isSuccess
				  ifTrue: [ 
					  (self
						   writeFutureOld: aResult value
						   new: anObject
						   using: aDescription) asAsyncPromise ]
				  ifFalse: [ aResult asAsyncPromise ] ] ]
]
