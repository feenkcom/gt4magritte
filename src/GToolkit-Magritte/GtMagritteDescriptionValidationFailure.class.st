Class {
	#name : #GtMagritteDescriptionValidationFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'description',
		'exception',
		'value'
	],
	#category : #'GToolkit-Magritte-Models'
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
GtMagritteDescriptionValidationFailure >> value [

	^ value
]

{ #category : #accessing }
GtMagritteDescriptionValidationFailure >> value: anObject [

	value := anObject
]
