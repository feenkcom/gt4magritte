Class {
	#name : #GtMagritteDummyPersonWithExtraActions,
	#superclass : #GtMagritteDummyPerson,
	#category : #'GToolkit4Magritte-Examples-Support'
}

{ #category : #accessing }
GtMagritteDummyPersonWithExtraActions >> magritteAcceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 10;
		label: 'New Accept';
		"isLabelVisible: false;"
		blocIcon: [ :aMemento :aDescription | 
			BrGlamorousVectorIcons accept ];
		action: [ :aModel :aButton :aMemento :aDescription | 
			aButton inUIProcessDo: [ aMemento commit ] ];
		onOverallStatusChanged: [ :aStatus :aButton :aMemento :aDescription | 
			aStatus isChanged
				ifTrue: [ aButton enabled: aStatus isValid ]
				ifFalse: [ aButton enabled: false ] ];
		beToolbarAction
]

{ #category : #accessing }
GtMagritteDummyPersonWithExtraActions >> magritteCancelAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 12;
		label: 'New Cancel';
		"isLabelVisible: false;"
		blocIcon: [ :aMemento :aDescription | 
			BrGlamorousVectorIcons cancel ];
		action: [ :aModel :aButton :aMemento :aDescription | 
			aButton inUIProcessDo: [ aMemento reset ] ];
		onOverallStatusChanged: [ :aStatus :aButton :aMemento :aDescription | 
			aStatus isChanged
				ifTrue: [ aButton enabled: true ]
				ifFalse: [ aButton enabled: false ] ];
		beToolbarAction
]

{ #category : #accessing }
GtMagritteDummyPersonWithExtraActions >> magritteInspectAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 20;
		label: 'New Inspect';
		blocIcon: [ :aMemento :aDescription | 
			BrGlamorousVectorIcons inspect ];
		action: [ :aModel :aButton :aMemento :aDescription | 
			aButton inUIProcessDo: [ aButton phlow spawnObject: aMemento  ] ];
		beToolbarAction
]
