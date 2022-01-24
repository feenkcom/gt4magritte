Extension { #name : #MAToManyRelationDescription }

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> blocItemStencil [

	^ self propertyAt: #blocItemStencil ifAbsentPut: [ 
		  [ :anItem | anItem asGtMagritteViewModel ] asStencilBuilder:
			  BrListRowStencilBuilder ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> blocItemStencil: aStencil [

	self propertyAt: #blocItemStencil put: aStencil
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> newItemStencil [

	^ self propertyAt: #newItemStencil ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> newItemStencil: aStencil [

	self propertyAt: #newItemStencil put: aStencil
]
