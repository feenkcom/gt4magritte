Extension { #name : #Object }

{ #category : #'*GToolkit-Magritte-Core' }
Object >> asGtMagritteAsyncViewModel [

	^ GtMagritteViewModel forObject: self
]

{ #category : #'*GToolkit-Magritte-Core' }
Object >> asGtMagritteAsyncViewModelWithDescription: aDescription [

	^ GtMagritteViewModel forObject: self description: aDescription
]

{ #category : #'*GToolkit-Magritte-Core' }
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
		  stencil: [ 
			  (self asGtMagritteAsyncViewModelWithDescription: aDescription)
				  asElement ]
]
