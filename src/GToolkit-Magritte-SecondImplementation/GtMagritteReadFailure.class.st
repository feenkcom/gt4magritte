Class {
	#name : #GtMagritteReadFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'exception',
		'context'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
}

{ #category : #accessing }
GtMagritteReadFailure >> context [

	^ context
]

{ #category : #accessing }
GtMagritteReadFailure >> context: anObject [

	context := anObject
]

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
