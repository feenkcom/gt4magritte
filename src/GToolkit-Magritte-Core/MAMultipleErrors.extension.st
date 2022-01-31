Extension { #name : #MAMultipleErrors }

{ #category : #'*GToolkit-Magritte-Core' }
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

{ #category : #'*GToolkit-Magritte-Core' }
MAMultipleErrors >> gtMagritteErrorsDo: aBlock [

	self collection do: [ :eachError | 
		eachError gtMagritteErrorsDo: aBlock ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAMultipleErrors >> gtMagritteErrorsDo: aMainBlock separatedBy: aSeparationBlock [

	self collection
		do: [ :eachError | 
			eachError
				gtMagritteErrorsDo: aMainBlock
				separatedBy: aSeparationBlock ]
		separatedBy: aSeparationBlock
]

{ #category : #'*GToolkit-Magritte-Core' }
MAMultipleErrors >> gtMagritteErrorsViewChildren [

	^ self collection ifNil: [ #(  ) ]
]