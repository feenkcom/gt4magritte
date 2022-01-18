Extension { #name : #Object }

{ #category : #'*GToolkit-Magritte' }
Object >> asGtMagritteNewViewModel [

	^ GtMagritteNewViewModel new memento:
		  (GtMagritteMemento forObject: self)
]

{ #category : #'*GToolkit-Magritte' }
Object >> asGtMagritteViewModel [

	^ GtMagritteViewModel new object: self
]

{ #category : #'*GToolkit-Magritte' }
Object >> gtGtMagritteFor: aView context: aContext [

	<gtView>
	| aDescription |
	aDescription := self magritteDescription.

	(aDescription isContainer not or: [ aDescription isEmpty ]) ifTrue: [ 
		^ aView empty ].

	^ aView explicit
		  title: 'Magritte 2';
		  priority: 49;
		  stencil: [ 
			  self asGtMagritteViewModel objectDescription: aDescription ]
]

{ #category : #'*GToolkit-Magritte' }
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
