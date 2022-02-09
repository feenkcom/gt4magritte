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

	<gtView>
	"We do not compute descriptions because this can be expensive
	and we want the view to be fast."
	self hasMagritteDescription ifFalse: [ ^ aView empty ].

	^ aView explicit
		  title: 'GT Magritte';
		  priority: 49;
		  stencil: [ self asGtMagritteViewModel ];
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Memento'
		  tooltip: 'Inspect Memento'
		  action: [ :aButton :aTab | 
			  aTab viewContentElement
				  allChildrenBreadthFirstDetect: [ :anElement | 
					  anElement userData includesKey:
							  GtMagritteViewModel gtMementoSymbol ]
				  ifFound: [ :anElement | 
					  aButton phlow spawnObject:
							  (anElement userData at: GtMagritteViewModel gtMementoSymbol) ] ]
]

{ #category : #'*GToolkit4Magritte-Core' }
Object >> hasMagritteDescription [

	^ Pragma hasNamed: #magritteDescription from: self class to: Object
]