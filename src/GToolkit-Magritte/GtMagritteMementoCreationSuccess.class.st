Class {
	#name : #GtMagritteMementoCreationSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'object',
		'description'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> description [

	^ description
]

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> descriptions [

	^ self description children
]

{ #category : #testing }
GtMagritteMementoCreationSuccess >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> object [

	^ object
]

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> object: anObject [

	object := anObject
]
