Class {
	#name : #GtMagritteResult,
	#superclass : #Object,
	#instVars : [
		'memento'
	],
	#category : #'GToolkit-Magritte-SecondImplementation-Models'
}

{ #category : #'gt - extensions' }
GtMagritteResult >> gtGtMagritteFor: aView context: aContext [

	<gtView>
	self memento ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'Old Memento';
		  priority: 1;
		  object: [ self memento ];
		  view: #gtGtMagritteFor:context:
]

{ #category : #'gt - extensions' }
GtMagritteResult >> gtGtNewMagritteFor: aView context: aContext [

	<gtView>
	self memento ifNil: [ ^ aView empty ].

	^ aView forward
		  title: 'New Memento';
		  priority: 0;
		  object: [ self memento ];
		  view: #gtGtNewMagritteFor:context:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'GT'
		  tooltip: 'Inspect GToolkit Memento'
		  action: [ :aButton | aButton phlow spawnObject: self memento ]
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
