Class {
	#name : #GtMagrittePasswordEditorElementStencilBuilder,
	#superclass : #GtMagritteDescriptionElementStencilBuilder,
	#category : #'GToolkit4Magritte-Core-Widgets Stencil Builders'
}

{ #category : #accessing }
GtMagrittePasswordEditorElementStencilBuilder >> buildDefault [
	<return: #BlElement>
	^ GtMagrittePasswordEditorElement new
		fieldViewModel: (GtMagritteFieldViewModel new
				memento: memento;
				description: description)
]
