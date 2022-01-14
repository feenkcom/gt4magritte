Class {
	#name : #GtMagritteWriteFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'oldValue',
		'newValue',
		'exception',
		'context',
		'original'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteWriteFailure >> context [

	^ context
]

{ #category : #accessing }
GtMagritteWriteFailure >> context: anObject [

	context := anObject
]

{ #category : #accessing }
GtMagritteWriteFailure >> description [

	^ description
]

{ #category : #accessing }
GtMagritteWriteFailure >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteWriteFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteWriteFailure >> exception: anObject [

	exception := anObject
]

{ #category : #accessing }
GtMagritteWriteFailure >> newValue [

	^ newValue
]

{ #category : #accessing }
GtMagritteWriteFailure >> newValue: anObject [

	newValue := anObject
]

{ #category : #accessing }
GtMagritteWriteFailure >> oldValue [

	^ oldValue
]

{ #category : #accessing }
GtMagritteWriteFailure >> oldValue: anObject [

	oldValue := anObject
]

{ #category : #accessing }
GtMagritteWriteFailure >> original [

	^ original
]

{ #category : #accessing }
GtMagritteWriteFailure >> original: anObject [

	original := anObject
]
