Extension { #name : #Object }

{ #category : #'*GToolkit4Magritte-Core' }
Object >> asGtMagritteViewModel [

	^ GtMagritteViewModel forObject: self
]

{ #category : #'*GToolkit4Magritte-Core' }
Object >> asGtMagritteViewModelWithDescription: aDescription [

	^ GtMagritteViewModel forObject: self description: aDescription
]

{ #category : #'*GToolkit4Magritte-Core' }
Object >> gtMagritteFor: aView [
	"We do not compute descriptions because this can be expensive
	and we want the view to be fast."

	<gtView>
	self hasMagritteDescription ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'GT Magritte';
		priority: 49;
		stencil: [ self asGtMagritteViewModel asElement margin: (BlInsets all: 10) ];
		actionButtonIcon: BrGlamorousVectorIcons inspect
			label: 'Memento'
			tooltip: 'Inspect Memento'
			action: [ :aButton :aTab | 
				aTab viewContentElement
					allChildrenBreadthFirstDetect: [ :anElement | anElement userData includesKey: GtMagritteViewModel gtMementoSymbol ]
					ifFound: [ :anElement | 
						aButton phlow
							spawnObject: (anElement userData at: GtMagritteViewModel gtMementoSymbol) ] ]
]

{ #category : #'*GToolkit4Magritte-Core' }
Object >> hasMagritteDescription [

	^ Pragma hasNamed: #magritteDescription from: self class to: Object
]

{ #category : #'*GToolkit4Magritte-Core' }
Object >> magritteAcceptAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 10;
		label: 'New Accept';
		"isLabelVisible: false;"
		blocIcon: BrGlamorousVectorIcons accept;
		action: (GtMagritteActionExecutor new
				beInUIProcess;
				beWithFutureResponse;
				beWithCallbacks;
				action: [ :aModel :aButton :aMemento :aDescription | aMemento commit ]);
		onOverallStatusChanged: (GtMagritteActionExecutor new
				beInUIProcess;
				action: [ :aStatus :aButton :aMemento :aDescription | 
					aStatus isChanged
						ifTrue: [ aButton enabled: aStatus isValid ]
						ifFalse: [ aButton enabled: false ] ]);
		beToolbarAction
]

{ #category : #'*GToolkit4Magritte-Core' }
Object >> magritteCancelAction [
	<magritteActionDescription>
	^ MAActionDescription new
		priority: 12;
		label: 'New Cancel';
		"isLabelVisible: false;"
		blocIcon: BrGlamorousVectorIcons cancel;
		action: (GtMagritteActionExecutor new
				beInUIProcess;
				beWithFutureResponse;
				beWithCallbacks;
				action: [ :aModel :aButton :aMemento :aDescription | aMemento reset ]);
		onOverallStatusChanged: (GtMagritteActionExecutor new
				beInUIProcess;
				action: [ :aStatus :aButton :aMemento :aDescription | aStatus isChanged
						ifTrue: [ aButton enabled: true ]
						ifFalse: [ aButton enabled: false ] ]);
		beToolbarAction
]
