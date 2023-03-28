Class {
	#name : #GtMagritteCallbackExecutor,
	#superclass : #GtMagritteAsyncActionExecutor,
	#instVars : [
		'actionExecutor'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #accessing }
GtMagritteCallbackExecutor >> actionExecutor [
	^ actionExecutor
]

{ #category : #accessing }
GtMagritteCallbackExecutor >> actionExecutor: anObject [
	actionExecutor := anObject
]

{ #category : #'private - hooks' }
GtMagritteCallbackExecutor >> onExecutionError: anException [
	super onExecutionError: anException.
	self actionExecutor ifNotNil: [ :anExecutor | 
		anExecutor registerCallback: self action error: anException ]
]
