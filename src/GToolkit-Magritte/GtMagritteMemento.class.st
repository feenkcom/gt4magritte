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
		'mementoPromise'
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
GtMagritteMemento >> clearReadStateUsing: aDescription [

	stateMutex critical: [ 
		readCache removeKey: aDescription ifAbsent: [ "ignore" ]. ].
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
GtMagritteMemento >> commitFutureContext: aContext [

	^ [ self computeCommitContext: aContext ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> commitPromise [

	^ promiseMutex critical: [ 
		  commitPromise ifNil: [ 
			  commitPromise := self validationPromise asyncThen: [ :aResult | 
				                   aResult isSuccess
					                   ifTrue: [ 
					                   self computeCommitContext: aResult context ]
					                   ifFalse: [ aResult ] ] ] ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeCommitContext: aContext [

	| aResult allValues |
	stateMutex critical: [ "cache locally old values"
		allValues := readCache copy.

		"commit values"
		[ aContext memento commit ]
			on: Error
			do: [ :anError | 
				aResult := GtMagritteCommitError new
					           memento: self;
					           exception: anError ].

		"clear cached values"
		allValues keysDo: [ :aDescription | 
			self clearReadStateUsing: aDescription ] ].

	"notify on value changes 
	- we notify only about previously cached values
	  as they are the only one users were previously interested"
	aResult ifNil: [ 
		allValues keysAndValuesDo: [ :aDescription :anOldPromise | 
			anOldPromise asyncThen: [ :anOldResult | 
				((anOldResult isSuccess and: [ anOldResult isChanged ]) or: [ 
					 anOldResult isSuccess not ]) ifTrue: [ 
					| aNewPromise |
					aNewPromise := self readPromiseUsing: aDescription.
					aNewPromise then: [ :aNewResult | 
						aNewResult isSuccess ifTrue: [ 
							self notifyValueCommitted: aNewResult using: aDescription ] ] ] ] ] ].

	aResult := aResult ifNil: [ 
		           GtMagritteCommitSuccess new memento: self ].

	self notifyCommitResult: aResult.

	^ aResult
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeReadUsing: aDescription context: aContext [

	| aValue aResponse anOriginalValue |
	[ 
	stateMutex critical: [ 
		aValue := aContext memento readUsing: aDescription.
		anOriginalValue := aContext memento readOriginalUsing: aDescription ] ]
		on: Error
		do: [ :anError | 
			aResponse := GtMagritteReadFailure new
				             memento: self;
				             description: aDescription;
				             exception: anError;
				             context: aContext ].

	^ aResponse ifNil: [ 
		  GtMagritteReadSuccess new
			  memento: self;
			  description: aDescription;
			  value: aValue;
			  original: anOriginalValue;
			  context: aContext ]
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeResetContext: aContext [

	| allValues aResult |
	stateMutex critical: [ 
		"cache locally old values"
		allValues := readCache copy.

		"reset memento"
		[ aContext memento reset ]
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
					self notifyValueChanged: aNewResult using: aDescription ] ] ] ].

	"return either reset failure or success result"
	^ aResult ifNil: [ GtMagritteResetSuccess new memento: self ]
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
GtMagritteMemento >> computeValidationContext: aContext [

	| aResult |
	stateMutex critical: [ 
		[ aContext memento validate ]
			on: MAValidationError
			do: [ :anError | 
				aResult := GtMagritteValidationFailure new
					           memento: self;
					           exception: anError;
					           context: aContext ] ].

	aResult := aResult ifNil: [ 
		           GtMagritteValidationSuccess new
			           memento: self;
			           context: aContext ].

	self notifyValidationChanged: aResult.

	^ aResult
]

{ #category : #'private - actions' }
GtMagritteMemento >> computeWriteOld: anOldResult new: aNewValue using: aDescription context: aContext [

	| aResult aReadPromise |
	anOldResult value = aNewValue ifTrue: [ 
		^ GtMagritteWriteUnchanged new
			  memento: self;
			  description: aDescription;
			  value: anOldResult value;
			  original: anOldResult original;
			  context: aContext ].

	stateMutex critical: [ 
		[ aContext memento write: aNewValue using: aDescription ]
			on: Error
			do: [ :anError | 
				self clearStateUsing: aDescription.
				^ GtMagritteWriteFailure new
					  memento: self;
					  description: aDescription;
					  original: anOldResult original;
					  oldValue: anOldResult value;
					  newValue: aNewValue;
					  exception: anError;
					  context: aContext ].

		self clearStateUsing: aDescription.
		aResult := GtMagritteWriteSuccess new
			           memento: self;
			           description: aDescription;
			           original: anOldResult original;
			           value: aNewValue;
			           context: aContext.
		aReadPromise := aResult asAsyncPromise.
		readCache at: aDescription put: aReadPromise ].

	aReadPromise asyncThen: [ :aReadResult | 
		self notifyValueChanged: aResult using: aDescription ].

	^ aResult
]

{ #category : #'api - debug' }
GtMagritteMemento >> description [

	"I should be used only for debugging purposes.
	Use #mementoPromise in a production code."

	| aPromise |
	aPromise := self mementoPromise then: [ :aResult | 
		            aResult isSuccess
			            ifTrue: [ aResult description ]
			            ifFalse: [ nil ] ].

	^ aPromise wait
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
		  title: 'Old Memento';
		  priority: 1;
		  object: [ self memento ];
		  view: #gtGtMagritteFor:context:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'RAW'
		  tooltip: 'Inspect RAW memento'
		  action: [ :aButton | aButton phlow spawnObject: self memento ]
]

{ #category : #accessing }
GtMagritteMemento >> gtGtNewMagritteFor: aView context: aContext [

	<gtView>
	self mementoPromise ifNil: [ ^ aView empty ].

	^ aView explicit
		  title: 'New Memento';
		  priority: 0;
		  stencil: [ 
			  GtMagritteNewEditableElementBuilder new
				  memento: self;
				  addButtons;
				  asElement ];
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'RAW'
		  tooltip: 'Inspect RAW Memento'
		  action: [ :aButton | aButton phlow spawnObject: self memento ]
]

{ #category : #'gt - extensions' }
GtMagritteMemento >> gtReadCacheFor: aView [

	<gtView>
	readCache ifEmpty: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Read Cache';
		  priority: 10;
		  items: [ stateMutex critical: [ readCache copy associations ] ];
		  column: 'Description' text: [ :anAssoc | anAssoc key label ];
		  column: 'Value' text: [ :anAssoc | 
			  | aResult |
			  aResult := anAssoc value wait.
			  aResult isSuccess
				  ifTrue: [ aResult value ]
				  ifFalse: [ 
					  aResult exception messageText asRopedText foreground:
							  BrGlamorousColors errorBackgroundColor ] ]
		  weight: 2;
		  column: 'Original Value' text: [ :anAssoc | 
			  | aResult |
			  aResult := anAssoc value wait.
			  aResult isSuccess
				  ifTrue: [ 
					  aResult isChanged
						  ifTrue: [ aResult original asRopedText foreground:
							  BrGlamorousColors disabledButtonTextColor ]
						  ifFalse: [ '' ] ]
				  ifFalse: [ '' ] ]
		  weight: 2;
		  send: [ :anAssoc | anAssoc value wait ];
		  actionUpdateButtonTooltip: 'Update read cache'
]

{ #category : #accessing }
GtMagritteMemento >> gtValidationCacheFor: aView [

	<gtView>
	readCache ifEmpty: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Validation Cache';
		  priority: 11;
		  items: [ 
			  stateMutex critical: [ validationCache copy associations ] ];
		  column: 'Description' text: [ :anAssoc | anAssoc key label ];
		  column: 'Value' text: [ :anAssoc | anAssoc value wait value ];
		  column: 'Validation Status' text: [ :anAssoc | 
			  | aResult |
			  aResult := anAssoc value wait.
			  aResult isSuccess
				  ifTrue: [ 
					  'Success' asRopedText foreground:
							  BrGlamorousColors successBackgroundColor ]
				  ifFalse: [ 
					  aResult issuesDescription asRopedText foreground:
							  BrGlamorousColors errorBackgroundColor ] ]
		  weight: 2;
		  send: [ :anAssoc | anAssoc value wait ];
		  actionUpdateButtonTooltip: 'Update validation cache'
]

{ #category : #initialization }
GtMagritteMemento >> initialize [

	super initialize.

	promiseMutex := Mutex new.
	stateMutex := Mutex new.
	readCache := SmallDictionary new.
	validationCache := SmallDictionary new.
]

{ #category : #'api - debug' }
GtMagritteMemento >> memento [

	"I should be used only for debugging purposes.
	Use #mementoPromise in a production code."

	| aPromise |
	aPromise := self mementoPromise then: [ :aResult | 
		            aResult isSuccess
			            ifTrue: [ aResult memento ]
			            ifFalse: [ nil ] ].

	^ aPromise wait
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

{ #category : #'private - notifying' }
GtMagritteMemento >> notifyCommitResult: aResult [

	announcer ifNil: [ ^ self ].

	self mementoPromise asyncThen: [ :aMementoResult | 
		announcer announce: (GtMagritteMementoCommittedAnnouncement new
				 memento: self;
				 result: aResult) ]
]

{ #category : #'private - notifying' }
GtMagritteMemento >> notifyValidationChanged: aResult [

	announcer ifNil: [ ^ self ].

	self mementoPromise asyncThen: [ :aMementoResult | 
		announcer announce:
			(GtMagritteMementoValidationChangedAnnouncement new
				 memento: self;
				 result: aResult) ]
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
GtMagritteMemento >> notifyValueChanged: aResult using: aDescription [

	announcer ifNil: [ ^ self ].

	announcer announce: (GtMagritteModelValueChangedAnnouncement new
			 memento: self;
			 result: aResult;
			 description: aDescription)
]

{ #category : #'private - notifying' }
GtMagritteMemento >> notifyValueCommitted: aResult using: aDescription [

	announcer ifNil: [ ^ self ].

	self mementoPromise then: [ :theResult | 
		announcer announce: (GtMagritteMementoValueCommittedAnnouncement new
				 memento: self;
				 result: aResult) ]
]

{ #category : #'api - debug' }
GtMagritteMemento >> object [

	"I should be used only for debugging purposes.
	Use #mementoPromise in a production code."

	| aPromise |
	aPromise := self mementoPromise then: [ :aResult | 
		            aResult isSuccess
			            ifTrue: [ aResult object ]
			            ifFalse: [ nil ] ].

	^ aPromise wait
]

{ #category : #printing }
GtMagritteMemento >> printOn: aStream [

	| aModel |
	super printOn: aStream.

	self mementoPromise ifNil: [ ^ self ].

	aModel := self object.

	aStream
		nextPut: $(;
		print: aModel;
		nextPut: $)
]

{ #category : #'private - accessing' }
GtMagritteMemento >> readFutureUsing: aDescription context: aContext [

	^ [ self computeReadUsing: aDescription context: aContext ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> readPromiseUsing: aDescription [

	^ promiseMutex critical: [ 
		  self cacheAt: aDescription ifAbsentPut: [ 
			  self mementoPromise then: [ :aResult | 
				  aResult isSuccess
					  ifTrue: [ 
					  (self readFutureUsing: aDescription context: aResult)
						  asAsyncPromise ]
					  ifFalse: [ aResult ] ] ] ]
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
GtMagritteMemento >> resetFutureContext: aContext [

	^ [ self computeResetContext: aContext ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> resetPromise [

	^ promiseMutex critical: [ 
		  resetPromise ifNil: [ 
			  resetPromise := self mementoPromise then: [ :aResult | 
				                  aResult isSuccess
					                  ifTrue: [ 
					                  (self resetFutureContext: aResult)
						                  asAsyncPromise ]
					                  ifFalse: [ aResult ] ] ] ]
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
GtMagritteMemento >> validationFuture: anObject using: aDescription [

	^ [ self computeValidation: anObject using: aDescription ]
		  asAsyncFuture
]

{ #category : #'private - accessing' }
GtMagritteMemento >> validationFutureContext: aContext [

	^ [ self computeValidationContext: aContext ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> validationPromise [

	^ promiseMutex critical: [ 
		  validationPromise ifNil: [ 
			  validationPromise := self mementoPromise asyncThen: [ :aResult | 
				                       aResult isSuccess
					                       ifTrue: [ 
					                       	self computeValidationContext: aResult ]
					                       ifFalse: [ aResult ] ] ] ]
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
GtMagritteMemento >> writeFutureOld: anOldResult new: aNewValue using: aDescription context: aContext [

	^ [ 
	  self
		  computeWriteOld: anOldResult
		  new: aNewValue
		  using: aDescription
		  context: aContext ] asAsyncFuture
]

{ #category : #'api - actions' }
GtMagritteMemento >> writePromise: anObject using: aDescription [

	^ promiseMutex critical: [ 
		  (self readPromiseUsing: aDescription) then: [ :aResult | 
			  aResult isSuccess
				  ifTrue: [ 
					  (self
						   writeFutureOld: aResult
						   new: anObject
						   using: aDescription
						   context: aResult context) asAsyncPromise ]
				  ifFalse: [ aResult asAsyncPromise ] ] ]
]
