Class {
	#name : #GtMagritteValidationFailure,
	#superclass : #GtMagritteResult,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Magritte-Models'
}

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
