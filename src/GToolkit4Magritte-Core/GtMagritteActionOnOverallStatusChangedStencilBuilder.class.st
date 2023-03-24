Class {
	#name : #GtMagritteActionOnOverallStatusChangedStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'description',
		'memento',
		'status',
		'element'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - instantiation' }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> buildDefault [
	^ nil
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> description [

	^ description
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> element [
	^ element
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #'api - instantiation' }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> paramsOn: aStencilExecutor [

	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self status;
		push: self element;
		push: self memento;
		push: self description
]

{ #category : #initialization }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> reset [
	status := nil.
	element := nil.
	memento := nil.
	description := nil
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> status [
	^ status
]

{ #category : #accessing }
GtMagritteActionOnOverallStatusChangedStencilBuilder >> status: anObject [
	status := anObject
]
