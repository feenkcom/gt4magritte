Class {
	#name : #GtMagritteResult,
	#superclass : #Object,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit-Magritte-Models'
}

{ #category : #'gt - extensions' }
GtMagritteResult >> gtGtMagritteFor: aView context: aContext [

	<gtView>
	self memento ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Memento';
		  priority: 1;
		  object: [ self memento ];
		  view: #gtGtMagritteFor:context:
]

{ #category : #testing }
GtMagritteResult >> isSuccess [

	^ false
]

{ #category : #accessing }
GtMagritteResult >> memento [

	^ memento
]

{ #category : #accessing }
GtMagritteResult >> memento: anObject [

	memento := anObject
]
