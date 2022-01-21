Extension { #name : #Object }

{ #category : #'*GToolkit-Magritte-FirstImplementation' }
Object >> asGtMagritteViewModel [

	^ GtMagritteViewModel new object: self
]

{ #category : #'*GToolkit-Magritte-FirstImplementation' }
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
