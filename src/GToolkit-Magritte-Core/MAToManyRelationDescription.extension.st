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
MAToManyRelationDescription >> blocItemViewModelStencil [

	^ self
		  propertyAt: #blocItemViewModelStencil
		  ifAbsent: [ GtMagritteModelStencilBuilder new ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> blocItemViewModelStencil: aStencil [

	self
		propertyAt: #blocItemViewModelStencil
		put: (aStencil asStencilBuilder: GtMagritteModelStencilBuilder)
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> blocListStencil [

	^ self
		  propertyAt: #blocListStencil
		  ifAbsent: [ GtMagritteListElementStencilBuilder new ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> blocListStencil: aStencil [

	self
		propertyAt: #blocListStencil
		put: (aStencil asStencilBuilder: GtMagritteListElementStencilBuilder)
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> newItemStencil [

	^ self propertyAt: #newItemStencil ifAbsent: [ nil ]
]

{ #category : #'*GToolkit-Magritte-Core' }
MAToManyRelationDescription >> newItemStencil: aStencil [

	self propertyAt: #newItemStencil put: aStencil
]
