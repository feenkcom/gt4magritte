Extension { #name : #MAContainer }

{ #category : #'*GToolkit-Magritte' }
MAContainer >> gtChildrenFor: aView [

	<gtView>
	self children ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Descriptions';
		  priority: 51;
		  items: [ self children ];
		  column: 'Label' text: #label;
		  column: 'Comment' text: [ :e | e comment ifNil: [ '' ] ] weight: 3
]
