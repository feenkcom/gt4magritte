Extension { #name : #MADescription }

{ #category : #'*GToolkit-Magritte' }
MADescription >> gtConditionsFor: aView [

	<gtView>
	(self hasProperty: #conditions) ifFalse: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Conditions';
		  priority: 55;
		  items: [ self conditions ];
		  column: 'Valuable' text: #key;
		  column: 'Description' text: #value;
		  send: #key
]
