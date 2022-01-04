Extension { #name : #MAMultipleErrors }

{ #category : #'*GToolkit-Magritte' }
MAMultipleErrors >> gtErrorsFor: aView [

	<gtView>
	self collection ifNil: [ ^ aView empty ].

	^ aView tree
		  title: 'Magritte Errors';
		  priority: 1;
		  items: [ self collection ];
		  children: #gtMagritteErrorsViewChildren;
		  itemText: #greaseString;
		  expandAll
]

{ #category : #'*GToolkit-Magritte' }
MAMultipleErrors >> gtMagritteErrorsDo: aBlock [

	self collection do: [ :eachError | 
		eachError gtMagritteErrorsDo: aBlock ]
]

{ #category : #'*GToolkit-Magritte' }
MAMultipleErrors >> gtMagritteErrorsViewChildren [

	^ self collection ifNil: [ #(  ) ]
]
