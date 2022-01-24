Class {
	#name : #GtMagritteAsyncValidationFailure,
	#superclass : #Object,
	#instVars : [
		'value',
		'exception'
	],
	#category : #'GToolkit-Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> exception: anObject [

	exception := anObject
]

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> gtIssuesDescriptionFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].

	^ aView textEditor
		  title: 'Issues Description';
		  priority: 3;
		  glamorousRegularFontAndSize;
		  text: [ self issuesDescription ]
]

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> isSuccess [

	^ false
]

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> issuesDescription [

	^ String streamContents: [ :aStream | 
		  self exception
			  gtMagritteErrorsDo: [ :eachError | 
			  aStream nextPutAll: eachError messageText asString ]
			  separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> value [

	<return: #GtMagritteValue>
	^ value
]

{ #category : #accessing }
GtMagritteAsyncValidationFailure >> value: anObject [

	value := anObject
]
