Extension { #name : #MAOptionDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAOptionDescription >> blocItemDataBinderStencil [

	^ self propertyAt: #blocItemDataBinderStencil ifAbsentPut: [ 
		  [ :anItemElement :anItemObject :anItemIndex | 
		  anItemElement text: (self displayStringFor: anItemObject) ] ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAOptionDescription >> blocItemStencil [

	^ self propertyAt: #blocItemStencil ifAbsentPut: [ 
		  [ :anItemType :aListWidget | 
		  BrLabel new
			  fitContent;
			  aptitude: BrGlamorousLabelAptitude
				  + (BrStyleCommonAptitude new hovered: [ :aStyle | 
							   aStyle background: BrGlamorousColors hoveredListItemColor ]) ] ]
]
