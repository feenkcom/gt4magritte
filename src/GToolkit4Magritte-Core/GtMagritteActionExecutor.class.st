Class {
	#name : #GtMagritteActionExecutor,
	#superclass : #GtMagritteBasicActionExecutor,
	#instVars : [
		'isWithCallbacks',
		'isWithStatusUpdates'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #'private - execution' }
GtMagritteActionExecutor >> attachFutureTask: anAsyncFuture [
	self element ifNil: [ ^ self ].

	self element
		enqueueTask: (BlPromiseTask new promise: anAsyncFuture asAsyncPromise)
]

{ #category : #execution }
GtMagritteActionExecutor >> execute [
	self executionAboutToStart.
	self usedProcess executeAction: self
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeErrorCallback: aCallback exception: anException [
	aCallback
		cull: anException
		cull: self element
		cull: self memento
		cull: self description
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeErrorCallbacks: anException [
	self isWithCallbacks ifFalse: [ 
		anException pass.
		^ self ].

	self description onErrorCallbacks do: [ :aCallback | 
		self 
			executeErrorCallback: aCallback 
			exception: anException ]
]

{ #category : #execution }
GtMagritteActionExecutor >> executeInActiveProcess [
	self executeActionWithCallbacks
]

{ #category : #execution }
GtMagritteActionExecutor >> executeInFutureProcess [
	<return: #TAsyncPromise>
	| aFuture aPromise |
	self element
		ifNil: [ self executeInActiveProcess.
			^ nil ].

	aFuture := (MessageSend 
		receiver: self 
		selector: #executeActionWithCallbacks)
			asAsyncFuture.
	aPromise := aFuture
			await: (GtMagritteBuilderUtility executionConfigutation
				errorHandler: AsyncPassExceptionHandler new).

	self element enqueueTask: (BlPromiseTask new promise: aPromise).

	^ aPromise
]

{ #category : #execution }
GtMagritteActionExecutor >> executeInUIProcess [
	self element ifNil: [ 
		self executeInActiveProcess.
		^ self ].

	self element inUIProcessDo: [ self executeActionWithCallbacks ]
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeSuccessCallback: aCallback result: aResult [
	aCallback
		cull: aResult
		cull: self element
		cull: self memento
		cull: self description
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeSuccessCallbacks: aResult [
	self isWithCallbacks ifFalse: [ ^ self ].

	self description onSuccessCallbacks
		do: [ :aCallback | self executeSuccessCallback: aCallback result: aResult ]
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executionAboutToStart [
	self memento executionStatus: GtMagritteExecutionStatus executing
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executionError: anException [
	self memento executionStatus: (GtMagritteExecutionStatus exception: anException)
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executionFinished [
	self memento executionStatus: GtMagritteExecutionStatus inactive
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executionStarted [
	self memento executionStatus: GtMagritteExecutionStatus executing
]

{ #category : #'gt - extensions' }
GtMagritteActionExecutor >> gtSourceCodeFor: aView [
	<gtView>
	
	(self action respondsTo: #gtSourceCodeFor:) ifFalse: [ ^ aView empty ].
	
	^ aView forward
		title: 'Source code';
		priority: 1;
		object: [ self action ];
		view: #gtSourceCodeFor:
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
GtMagritteActionExecutor >> isWithFutureResponse [
	^ self action isWithFutureResponse
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
		self memento executionStatus: (GtMagritteExecutionStatus exception: anException)  ]
]

{ #category : #'private - hooks' }
GtMagritteActionExecutor >> onExecutionFinished: aResult [
	super onExecutionFinished: aResult.
	self isWithStatusUpdates ifTrue: [ 
		self memento executionStatus: GtMagritteExecutionStatus inactive ]
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

{ #category : #accessing }
GtMagritteActionExecutor >> usedProcess [
	^ self action usedProcess
]
