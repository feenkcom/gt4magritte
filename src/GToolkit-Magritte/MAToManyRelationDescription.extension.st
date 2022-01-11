Extension { #name : #MAToManyRelationDescription }

{ #category : #'*GToolkit-Magritte' }
MAToManyRelationDescription >> blocItemStencil [

	^ self
		  propertyAt: #blocItemStencil
		  ifAbsentPut:
			  ([ :anItem | anItem asGtMagritteViewModel ] asStencilBuilder:
				   BrListRowStencilBuilder)
]

{ #category : #'*GToolkit-Magritte' }
MAToManyRelationDescription >> blocItemStencil: aStencil [

	self propertyAt: #blocItemStencil put: aStencil
]
