Extension { #name : #Object }

{ #category : #'*GToolkit-Magritte' }
Object >> asGtMagritteAsyncViewModel [

	^ GtMagritteAsyncViewModel forObject: self
]

{ #category : #'*GToolkit-Magritte' }
Object >> gtMagritteFor: aView [

	<gtView>
	| aDescription |
	"Cache the description because this can be expensive and we want the view to be fast not to break the debugging workflow"
	aDescription := self magritteDescription.

	(aDescription isContainer not or: [ aDescription isEmpty ]) ifTrue: [ 
		^ aView empty ].

	^ aView explicit
		  title: 'GT Magritte';
		  priority: 49;
		  stencil: [ self asGtMagritteAsyncViewModel asElement ]
]
