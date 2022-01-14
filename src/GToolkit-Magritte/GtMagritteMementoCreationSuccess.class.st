Class {
	#name : #GtMagritteMementoCreationSuccess,
	#superclass : #GtMagritteResult,
	#instVars : [
		'object',
		'description'
	],
	#category : #'GToolkit-Magritte-Utilities'
}

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> description [

	^ description
]

{ #category : #accessing }
GtMagritteMementoCreationSuccess >> description: anObject [

	description := anObject
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
