Class {
	#name : #GtMagritteActionExecutor,
	#superclass : #GtMagritteAsyncActionExecutor,
	#instVars : [
		'isWithCallbacks',
		'isWithStatusUpdates',
		'callbackErrors',
		'futureConfiguration'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #'private - execution' }
GtMagritteActionExecutor >> attachFutureTask: anAsyncFuture [
	| aPromise |
	self element ifNil: [ ^ self ].
	
	aPromise := anAsyncFuture asAsyncFuture await: self futureConfiguration.
	self element enqueueTask: (BlPromiseTask new promise: aPromise)
]

{ #category : #initialization }
GtMagritteActionExecutor >> defaultFutureConfiguration [
	^ GtPhlowUtility defaultFutureExecutionConfiguration
]

{ #category : #execution }
GtMagritteActionExecutor >> execute [
	self isWithStatusUpdates ifTrue: [ 
		self memento executionStatus: GtMagritteExecutionStatus executing ].
	super execute
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeCallback: aCallback object: anException [
	GtMagritteCallbackExecutor new 
		action: aCallback asGtMagritteCallback;
		object: anException;
		memento: self memento;
		description: self description;
		actionExecutor: self;
		element: element;
		execute
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeErrorCallbacks: anException [
	self isWithCallbacks ifFalse: [ 
		anException pass.
		^ self ].

	self description onErrorCallbacks do: [ :aCallback | 
		self 
			executeCallback: aCallback 
			object: anException ]
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeSuccessCallbacks: aResult [
	self isWithCallbacks ifFalse: [ ^ self ].

	self description onSuccessCallbacks
		do: [ :aCallback | self executeCallback: aCallback object: aResult ]
]

{ #category : #accessing }
GtMagritteActionExecutor >> futureConfiguration [
	<return: #AsyncFutureExecutionConfiguration>
	^ futureConfiguration ifNil: [ futureConfiguration := self defaultFutureConfiguration ]
]

{ #category : #accessing }
GtMagritteActionExecutor >> futureConfiguration: aFutureExecutionConfiguration [
	futureConfiguration := aFutureExecutionConfiguration
]

{ #category : #initialization }
GtMagritteActionExecutor >> initialize [
	super initialize.
	callbackErrors := AsyncSharedOrderedCollection new
]

{ #category : #accessing }
GtMagritteActionExecutor >> isWithCallbacks [
	^ isWithCallbacks ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteActionExecutor >> isWithCallbacks: aBoolean [
	isWithCallbacks := aBoolean
]

{ #category : #accessing }
GtMagritteActionExecutor >> isWithStatusUpdates [
	^ isWithStatusUpdates ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteActionExecutor >> isWithStatusUpdates: anObject [
	isWithStatusUpdates := anObject
]

{ #category : #'private - hooks' }
GtMagritteActionExecutor >> onExecutionError: anException [
	super onExecutionError: anException.
	self isWithCallbacks ifTrue: [ self executeErrorCallbacks: anException ].
	self isWithStatusUpdates ifTrue: [ 
		self memento executionStatus: (GtMagritteExecutionStatus exception: (GtMagritteActionUtility freeze: anException)) ]
]

{ #category : #'private - hooks' }
GtMagritteActionExecutor >> onExecutionFinished: aResult [
	super onExecutionFinished: aResult.
	self isWithStatusUpdates ifTrue: [ 
		callbackErrors asArray
			ifEmpty: [
				self memento executionStatus: 
					GtMagritteExecutionStatus inactive ]
			ifNotEmpty: [ :anArray | 
				"If we execute callbacks asynchronously,
				the action executor may not be notified on time.
				As a consequence users will obtain a visual notification
				of an async callback error."
				self memento executionStatus: (
					GtMagritteExecutionStatus callbackExceptions: anArray) ] ]
]

{ #category : #'private - hooks' }
GtMagritteActionExecutor >> onExecutionStarted [
	super onExecutionStarted.
	self isWithStatusUpdates ifTrue: [ 
		self memento executionStatus: GtMagritteExecutionStatus executing ]
]

{ #category : #'private - hooks' }
GtMagritteActionExecutor >> onMainActionFinished: aResult [
	super onMainActionFinished: aResult.
	self isWithFutureResponse ifTrue: [ self attachFutureTask: aResult ].
	self isWithCallbacks ifTrue: [ self executeSuccessCallbacks: aResult ]
]

{ #category : #execution }
GtMagritteActionExecutor >> registerCallback: aCallback error: anException [
	callbackErrors
		add: (GtMagritteCallbackError new
				callback: aCallback;
				exception: (GtMagritteActionUtility freeze: anException))
]
