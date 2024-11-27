Class {
	#name : #GtMagritteStringEditorElementStencilBuilder,
	#superclass : #GtMagritteDescriptionElementStencilBuilder,
	#category : #'GToolkit4Magritte-Core-Widgets Stencil Builders'
}

{ #category : #accessing }
GtMagritteStringEditorElementStencilBuilder >> buildDefault [
	<return: #BlElement>
	^ GtMagritteBuilderUtility
		newOneLineEditorWithMemento: memento
		using: description
]
