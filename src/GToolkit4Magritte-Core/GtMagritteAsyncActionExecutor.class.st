Class {
	#name : #GtMagritteAsyncActionExecutor,
	#superclass : #GtMagritteBasicActionExecutor,
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #execution }
GtMagritteAsyncActionExecutor >> execute [
	self usedProcess executeAction: self
]

{ #category : #execution }
GtMagritteAsyncActionExecutor >> executeInActiveProcess [
	self executeActionWithCallbacks
]

{ #category : #execution }
GtMagritteAsyncActionExecutor >> executeInFutureProcess [
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
GtMagritteAsyncActionExecutor >> executeInUIProcess [
	self element ifNil: [ 
		self executeInActiveProcess.
		^ self ].

	self element inUIProcessDo: [ self executeActionWithCallbacks ]
]

{ #category : #accessing }
GtMagritteAsyncActionExecutor >> isWithFutureResponse [
	^ self action isWithFutureResponse
]

{ #category : #accessing }
GtMagritteAsyncActionExecutor >> usedProcess [
	^ self action usedProcess
]
