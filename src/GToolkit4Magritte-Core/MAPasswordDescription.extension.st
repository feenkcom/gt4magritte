Extension { #name : #MAPasswordDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAPasswordDescription >> blocStencil [
	<return: #GtMagritteDescriptionElementStencilBuilder or: nil>
	^ self
		propertyAt: #blocStencil
		ifAbsentPut: [ GtMagrittePasswordEditorElementStencilBuilder new ]
]
