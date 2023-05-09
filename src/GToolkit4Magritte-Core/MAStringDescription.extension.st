Extension { #name : #MAStringDescription }

{ #category : #'*GToolkit4Magritte-Core' }
MAStringDescription >> blocStencil [
	<return: #GtMagritteDescriptionElementStencilBuilder or: nil>
	^ self
		propertyAt: #blocStencil
		ifAbsentPut: [ ^ GtMagritteStringEditorElementStencilBuilder new ]
]
