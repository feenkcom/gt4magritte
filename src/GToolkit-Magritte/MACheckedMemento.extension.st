Extension { #name : #MACheckedMemento }

{ #category : #'*GToolkit-Magritte' }
MACheckedMemento >> gtCachedAndOriginalValuesFor: aView [

	<gtView>
	self original ifNil: [ ^ aView empty ].
	self cache ifNil: [ ^ aView empty ].

	^ aView columnedList
		  title: 'Cached Values';
		  priority: 10;
		  items: [ self cache associations ];
		  column: 'Name' text: [ :anAssoc | anAssoc key label ];
		  column: 'Value' text: [ :anAssoc | anAssoc value ] weight: 2;
		  column: 'Value' text: [ :anAssoc | 
			  | anOriginal |
			  anOriginal := self original at: anAssoc key ifAbsent: [ nil ].
			  anOriginal = anAssoc value
				  ifTrue: [ '' ]
				  ifFalse: [ 
					  anOriginal asRopedText foreground:
							  BrGlamorousColors disabledButtonTextColor ] ]
		  weight: 2;
		  actionUpdateButtonTooltip: 'Update the list'
]

{ #category : #'*GToolkit-Magritte' }
MACheckedMemento >> readOriginalUsing: aDescription [

	^ self original at: aDescription
]
