Extension { #name : #MAToManyRelationDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> blocItemStencil [
	^ self
		propertyAt: #blocItemStencil
		ifAbsentPut: [ [ :anItem | 
			anItem asGtMagritteViewModel asElement
				margin: (BlInsets
						top: 0
						right: 10
						bottom: 10
						left: 0) ] asStencilBuilder: BrListRowStencilBuilder ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> blocItemStencil: aStencil [

	self propertyAt: #blocItemStencil put: aStencil
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> blocItemViewModelStencil [

	^ self
		  propertyAt: #blocItemViewModelStencil
		  ifAbsent: [ GtMagritteModelStencilBuilder new ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> blocItemViewModelStencil: aStencil [

	self
		propertyAt: #blocItemViewModelStencil
		put: (aStencil asStencilBuilder: GtMagritteModelStencilBuilder)
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> blocListStencil [

	^ self
		  propertyAt: #blocListStencil
		  ifAbsent: [ GtMagritteListElementStencilBuilder new ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> blocListStencil: aStencil [

	self
		propertyAt: #blocListStencil
		put: (aStencil asStencilBuilder: GtMagritteListElementStencilBuilder)
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> newItemStencil [

	^ self propertyAt: #newItemStencil ifAbsent: [ nil ]
]

{ #category : #'*GToolkit4Magritte-Core' }
MAToManyRelationDescription >> newItemStencil: aStencil [

	self propertyAt: #newItemStencil put: aStencil
]
