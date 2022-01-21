Extension { #name : #Object }

{ #category : #'*GToolkit-Magritte-SecondImplementation' }
Object >> asGtMagritteNewViewModel [

	^ GtMagritteNewViewModel new memento:
		  (GtMagritteMemento forObject: self)
]

{ #category : #'*GToolkit-Magritte-SecondImplementation' }
Object >> gtGtNewMagritteFor: aView context: aContext [

	<gtView>
	| aDescription aViewModel |
	aDescription := self magritteDescription.

	(aDescription isContainer not or: [ aDescription isEmpty ]) ifTrue: [ 
		^ aView empty ].



	^ aView explicit
		  title: 'Magritte 3';
		  priority: 48;
		  stencil: [ 
			  aViewModel := GtMagritteNewViewModel new memento:
					                (GtMagritteMemento
						                 forObject: self
						                 description: aDescription) ];
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Memento'
		  tooltip: 'Inspect GToolkit Memento'
		  action: [ :aButton | 
			  aButton phlow spawnObject: (aViewModel ifNotNil: #memento) ]
]
