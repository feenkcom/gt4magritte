Class {
	#name : #GtMagritteBasicActionExecutor,
	#superclass : #Object,
	#instVars : [
		'action',
		'description',
		'element',
		'memento',
		'object'
	],
	#category : #'GToolkit4Magritte-Core-Actions'
}

{ #category : #accessing }
GtMagritteBasicActionExecutor >> action [
	<return: #GtMagritteAction>
	^ action
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> block [
	^ self action action
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> description [
	^ description
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> description: anObject [
	description := anObject
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> element [
	^ element
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> element: anObject [
	element := anObject
]

{ #category : #'api - execution' }
GtMagritteBasicActionExecutor >> execute [
	self executeActionWithCallbacks
]

{ #category : #'private - execution' }
GtMagritteBasicActionExecutor >> executeActionWithCallbacks [
	[ | aResult |
	self onExecutionStarted.

	aResult := self block
			cull: self object
			cull: self element
			cull: self memento
			cull: self description.

	self onMainActionFinished: aResult.
	self onExecutionFinished: aResult ]
		on: Error
		do: [ :anException | 
			anException emit.
			self onExecutionError: anException ]
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> memento [
	^ memento
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> memento: anObject [
	memento := anObject
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> object [
	^ object
]

{ #category : #accessing }
GtMagritteBasicActionExecutor >> object: anObject [
	object := anObject
]

{ #category : #'private - hooks' }
GtMagritteBasicActionExecutor >> onExecutionError: anException [
]

{ #category : #'private - hooks' }
GtMagritteBasicActionExecutor >> onExecutionFinished: aResult [
]

{ #category : #'private - hooks' }
GtMagritteBasicActionExecutor >> onExecutionStarted [
]

{ #category : #'private - hooks' }
GtMagritteBasicActionExecutor >> onMainActionFinished: aResult [
	
]
