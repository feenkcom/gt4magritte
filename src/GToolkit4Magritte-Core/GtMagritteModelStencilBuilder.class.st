Class {
	#name : #GtMagritteModelStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'model',
		'description',
		'memento'
	],
	#category : #'GToolkit4Magritte-Core-Support'
}

{ #category : #'api - instantiation' }
GtMagritteModelStencilBuilder >> buildDefault [

	<return: #GtMagritteViewModel>
	^ self model asGtMagritteViewModel
]

{ #category : #accessing }
GtMagritteModelStencilBuilder >> description [

	^ description
]

{ #category : #accessing }
GtMagritteModelStencilBuilder >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteModelStencilBuilder >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteModelStencilBuilder >> memento: anObject [

	memento := anObject
]

{ #category : #accessing }
GtMagritteModelStencilBuilder >> model [

	^ model
]

{ #category : #accessing }
GtMagritteModelStencilBuilder >> model: anObject [

	model := anObject
]

{ #category : #'api - instantiation' }
GtMagritteModelStencilBuilder >> paramsOn: aStencilExecutor [

	super paramsOn: aStencilExecutor.
	aStencilExecutor
		push: self model;
		push: self description;
		push: self memento
]

{ #category : #initialization }
GtMagritteModelStencilBuilder >> reset [
	model := nil.
	description := nil.
	memento := nil
]
