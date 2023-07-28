Class {
	#name : #GtMagritteUpdateSpecificationContext,
	#superclass : #Object,
	#instVars : [
		'model',
		'description',
		'observable'
	],
	#category : #'GToolkit4Magritte-Core-Description Properties'
}

{ #category : #accessing }
GtMagritteUpdateSpecificationContext >> description [
	^ description
]

{ #category : #accessing }
GtMagritteUpdateSpecificationContext >> description: anObject [
	description := anObject
]

{ #category : #'gt - extensions' }
GtMagritteUpdateSpecificationContext >> gtDescriptionFor: aView [
	<gtView>
	self description ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Description';
		priority: 49;
		object: [ self description ];
		view: #gtMagritteFor:
]

{ #category : #accessing }
GtMagritteUpdateSpecificationContext >> model [
	^ model
]

{ #category : #accessing }
GtMagritteUpdateSpecificationContext >> model: anObject [
	model := anObject
]

{ #category : #accessing }
GtMagritteUpdateSpecificationContext >> observable [
	^ observable
]

{ #category : #accessing }
GtMagritteUpdateSpecificationContext >> observable: anObject [
	observable := anObject
]
