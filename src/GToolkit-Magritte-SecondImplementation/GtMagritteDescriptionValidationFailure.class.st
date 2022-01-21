Class {
	#name : #GtMagritteDescriptionValidationFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'exception',
		'result'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
}

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> description [

	^ description
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> description: anObject [

	description := anObject
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> exception: anObject [

	exception := anObject
]

{ #category : #'gt - extensions' }
GtMagritteDescriptionValidationFailure >> gtIssuesDescriptionFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].

	^ aView textEditor
		  title: 'Issues Description';
		  priority: 2;
		  glamorousRegularFontAndSize;
		  text: [ self issuesDescription ]
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> issuesDescription [

	^ String streamContents: [ :aStream | 
		  self exception
			  gtMagritteErrorsDo: [ :eachError | 
			  aStream nextPutAll: eachError messageText asString ]
			  separatedBy: [ aStream cr ] ]
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> result [

	^ result
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> result: aResult [

	result := aResult
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> value [

	^ self result value
]
