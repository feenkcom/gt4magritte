Class {
	#name : #GtMagritteResetFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
}

{ #category : #accessing }
GtMagritteResetFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteResetFailure >> exception: anObject [

	exception := anObject
]
