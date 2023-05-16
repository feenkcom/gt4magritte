Class {
	#name : #GtMagritteValidationFailure,
	#superclass : #Object,
	#instVars : [
		'value',
		'exception'
	],
	#category : #'GToolkit4Magritte-Core-Models'
}

{ #category : #accessing }
GtMagritteValidationFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteValidationFailure >> exception: anObject [

	exception := anObject
]

{ #category : #accessing }
GtMagritteValidationFailure >> gtIssuesDescriptionFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].

	^ aView textEditor
		  title: 'Issues description';
		  priority: 3;
		  glamorousRegularFontAndSize;
		  text: [ self issuesDescription ]
]

{ #category : #accessing }
GtMagritteValidationFailure >> isSuccess [

	^ false
]

{ #category : #accessing }
GtMagritteValidationFailure >> issuesDescription [

	^ String streamContents: [ :aStream | 
		  self exception
			  gtMagritteErrorsDo: [ :eachError | 
			  aStream nextPutAll: eachError messageText asString ]
			  separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
GtMagritteValidationFailure >> value [

	<return: #GtMagritteValue>
	^ value
]

{ #category : #accessing }
GtMagritteValidationFailure >> value: anObject [

	value := anObject
]
