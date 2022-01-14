Class {
	#name : #GtMagritteWriteUnchanged,
	#superclass : #GtMagritteResult,
	#instVars : [
		'value',
		'description',
		'context'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteWriteUnchanged >> context [

	^ context
]

{ #category : #accessing }
GtMagritteWriteUnchanged >> context: anObject [

	context := anObject
]

{ #category : #accessing }
GtMagritteWriteUnchanged >> description [

	^ description
]

{ #category : #accessing }
GtMagritteWriteUnchanged >> description: anObject [

	description := anObject
]

{ #category : #testing }
GtMagritteWriteUnchanged >> isSuccess [

	^ true
]

{ #category : #accessing }
GtMagritteWriteUnchanged >> value [

	^ value
]

{ #category : #accessing }
GtMagritteWriteUnchanged >> value: anObject [

	value := anObject
]
