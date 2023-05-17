Extension { #name : #MAMultipleErrors }

{ #category : #'*GToolkit4Magritte-Core' }
MAMultipleErrors >> gtErrorsFor: aView [

	<gtView>
	self collection ifNil: [ ^ aView empty ].

	^ aView tree
		  title: 'Magritte errors';
		  priority: 1;
		  items: [ self collection ];
		  children: #gtMagritteErrorsViewChildren;
		  itemText: #greaseString;
		  expandAll
]

{ #category : #'*GToolkit4Magritte-Core' }
MAMultipleErrors >> gtMagritteErrorsDo: aBlock [

	self collection do: [ :eachError | 
		eachError gtMagritteErrorsDo: aBlock ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAMultipleErrors >> gtMagritteErrorsDo: aMainBlock separatedBy: aSeparationBlock [

	self collection
		do: [ :eachError | 
			eachError
				gtMagritteErrorsDo: aMainBlock
				separatedBy: aSeparationBlock ]
		separatedBy: aSeparationBlock
]

{ #category : #'*GToolkit4Magritte-Core' }
MAMultipleErrors >> gtMagritteErrorsViewChildren [

	^ self collection ifNil: [ #(  ) ]
]
