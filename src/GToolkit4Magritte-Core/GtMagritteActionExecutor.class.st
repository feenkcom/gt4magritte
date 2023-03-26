Class {
	#name : #GtMagritteActionExecutor,
	#superclass : #Object,
	#instVars : [
		'element',
		'action',
		'memento',
		'description',
		'isWithFutureResponse',
		'object',
		'isWithCallbacks',
		'isWithReset',
		'usedProcess'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #accessing }
GtMagritteActionExecutor >> action [
	^ action
]

{ #category : #accessing }
GtMagritteActionExecutor >> action: anObject [
	action := anObject
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> attachFutureTask: anAsyncFuture [
	self element ifNil: [ ^ self ].

	self element
		enqueueTask: (BlPromiseTask new promise: anAsyncFuture asAsyncPromise)
]

{ #category : #accessing }
GtMagritteActionExecutor >> beInUIProcess [
	usedProcess := GtMagritteActionExecutorUsedProcess uiProcess
]

{ #category : #accessing }
GtMagritteActionExecutor >> beWithCallbacks [
	^ isWithCallbacks := true
]

{ #category : #accessing }
GtMagritteActionExecutor >> beWithFutureResponse [
	^ isWithFutureResponse := true
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> beWithReset [
	isWithReset := true
]

{ #category : #'api - execution' }
GtMagritteActionExecutor >> cull: anObject cull: anElement cull: aMemento cull: aDescription [
	self
		beWithReset;
		object: anObject;
		element: anElement;
		memento: aMemento;
		description: aDescription;
		execute
]

{ #category : #accessing }
GtMagritteActionExecutor >> description [
	^ description
]

{ #category : #accessing }
GtMagritteActionExecutor >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtMagritteActionExecutor >> element [
	^ element
]

{ #category : #accessing }
GtMagritteActionExecutor >> element: anObject [
	element := anObject
]

{ #category : #'api - execution' }
GtMagritteActionExecutor >> execute [
	self usedProcess executeAction: self.
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeActionWithCallbacks [
	[ [ | aResult |
	aResult := self action
			cull: self object
			cull: self element
			cull: self memento
			cull: self description.

	self isWithFutureResponse ifTrue: [ self attachFutureTask: aResult ].

	self executeSuccessCallbacks: aResult ]
		on: Error
		do: [ :anException | 
			anException emit.
			self executeErrorCallbacks: anException ] ]
		ensure: [ self isWithReset ifTrue: [ self reset ] ]
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
	self isWithCallbacks
		ifFalse: [ anException pass.
			^ self ].

	self description onErrorCallbacks ifEmpty: [ anException pass ].

	self description onErrorCallbacks
		do: [ :aCallback | self executeErrorCallback: aCallback exception: anException ]
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeInActiveProcess [
	self executeActionWithCallbacks
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> executeInUIProcess [
	self element
		ifNil: [ self executeInActiveProcess.
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

{ #category : #testing }
GtMagritteActionExecutor >> isWithCallbacks [
	^ isWithCallbacks ifNil: [ false ]
]

{ #category : #testing }
GtMagritteActionExecutor >> isWithFutureResponse [
	^ isWithFutureResponse ifNil: [ false ]
]

{ #category : #testing }
GtMagritteActionExecutor >> isWithReset [
	^ isWithReset ifNil: [ false ]
]

{ #category : #accessing }
GtMagritteActionExecutor >> memento [
	^ memento
]

{ #category : #accessing }
GtMagritteActionExecutor >> memento: anObject [
	memento := anObject
]

{ #category : #accessing }
GtMagritteActionExecutor >> object [
	^ object
]

{ #category : #accessing }
GtMagritteActionExecutor >> object: anObject [
	object := anObject
]

{ #category : #'private - execution' }
GtMagritteActionExecutor >> reset [
	element := nil.
	memento := nil.
	description := nil
]

{ #category : #accessing }
GtMagritteActionExecutor >> usedProcess [
	^ usedProcess ifNil: [ GtMagritteActionExecutorUsedProcess default  ]
]
