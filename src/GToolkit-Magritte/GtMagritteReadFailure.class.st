Class {
	#name : #GtMagritteReadFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'exception'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteReadFailure >> description [

	^ description
]

{ #category : #accessing }
GtMagritteReadFailure >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteReadFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteReadFailure >> exception: anObject [

	exception := anObject
]