Class {
	#name : #GtMagritteModelStencilBuilder,
	#superclass : #BrStencilBuilder,
	#instVars : [
		'model',
		'description'
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
		push: self description
]
