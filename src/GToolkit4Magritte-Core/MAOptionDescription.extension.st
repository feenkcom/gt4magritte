Extension { #name : #MAOptionDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAOptionDescription >> blocItemDataBinderStencil [

	^ self propertyAt: #blocItemDataBinderStencil ifAbsentPut: [ 
		  [ :anItemElement :anItemObject :anItemIndex | 
		  anItemElement text: anItemObject asString ] ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAOptionDescription >> blocItemStencil [

	^ self propertyAt: #blocItemStencil ifAbsentPut: [ 
		  [ :anItemType :aListWidget | 
		  BrLabel new
			  fitContent;
			  aptitude: BrGlamorousLabelAptitude ] ]
]
