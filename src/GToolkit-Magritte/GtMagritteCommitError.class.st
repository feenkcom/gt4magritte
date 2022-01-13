Class {
	#name : #GtMagritteCommitError,
	#superclass : #GtMagritteResult,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteCommitError >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteCommitError >> exception: anObject [

	exception := anObject
]
