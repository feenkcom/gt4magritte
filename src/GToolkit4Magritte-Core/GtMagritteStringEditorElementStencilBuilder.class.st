Class {
	#name : #GtMagritteStringEditorElementStencilBuilder,
	#superclass : #GtMagritteDescriptionElementStencilBuilder,
	#category : #'GToolkit4Magritte-Core-Widgets Stencil Builders'
}

{ #category : #accessing }
GtMagritteStringEditorElementStencilBuilder >> buildDefault [
	<return: #BlElement>
	| anInputElement |
	description isReadOnly
		ifTrue: [ anInputElement := GtMagritteBuilderUtility
					newReadOnlyEditorWithMemento: memento
					using: description ]
		ifFalse: [ description isAlwaysEditable
				ifFalse: [ anInputElement := GtMagritteBuilderUtility
							newEditableLabelWithMemento: memento
							using: description ]
				ifTrue: [ anInputElement := GtMagritteBuilderUtility
							newOneLineEditorWithMemento: memento
							using: description ] ].

	^ anInputElement
]
