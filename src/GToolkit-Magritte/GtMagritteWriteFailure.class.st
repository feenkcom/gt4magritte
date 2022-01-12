Class {
	#name : #GtMagritteWriteFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'oldValue',
		'newValue',
		'exception'
	],
	#category : #'GToolkit-Magritte-Models'
}

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
