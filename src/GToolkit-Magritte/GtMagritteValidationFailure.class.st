Class {
	#name : #GtMagritteValidationFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'exception',
		'context'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #accessing }
GtMagritteValidationFailure >> context [

	^ context
]

{ #category : #accessing }
GtMagritteValidationFailure >> context: anObject [

	context := anObject
]

{ #category : #accessing }
GtMagritteValidationFailure >> exception [

	^ exception
]

{ #category : #accessing }
GtMagritteValidationFailure >> exception: anObject [

	exception := anObject
]

{ #category : #'gt - extensions' }
GtMagritteValidationFailure >> gtErrorsFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].

	^ aView tree
		  title: 'Validation Issues';
		  priority: 2;
		  items: [ self exception collection ];
		  children: #gtMagritteErrorsViewChildren;
		  itemText: #greaseString;
		  expandAll
]

{ #category : #'gt - extensions' }
GtMagritteValidationFailure >> gtIssuesDescriptionFor: aView [

	<gtView>
	self exception ifNil: [ ^ aView empty ].

	^ aView textEditor
		  title: 'Issues Description';
		  priority: 3;
		  glamorousRegularFontAndSize;
		  text: [ self issuesDescription ]
]

{ #category : #accessing }
GtMagritteValidationFailure >> issuesDescription [

	^ String streamContents: [ :aStream | 
		  self exception
			  gtMagritteErrorsDo: [ :eachError | 
			  aStream nextPutAll: eachError messageText asString ]
			  separatedBy: [ aStream cr ] ]
]
