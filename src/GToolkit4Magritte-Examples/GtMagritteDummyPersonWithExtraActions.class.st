Class {
	#name : #GtMagritteDummyPersonWithExtraActions,
	#superclass : #GtMagritteDummyPerson,
	#category : #'GToolkit4Magritte-Examples-Support'
}

{ #category : #accessing }
GtMagritteDummyPersonWithExtraActions >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 20;
		label: 'New Inspect';
		blocIcon: BrGlamorousVectorIcons inspect;
		action: [ :aModel :aButton :aMemento :aDescription | 
			aButton inUIProcessDo: [ aButton phlow spawnObject: aMemento  ] ];
		beToolbarAction
]
