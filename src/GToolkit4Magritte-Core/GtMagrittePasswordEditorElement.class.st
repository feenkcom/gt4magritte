Class {
	#name : #GtMagrittePasswordEditorElement,
	#superclass : #GtMagritteOneLineEditorElement,
	#category : #'GToolkit4Magritte-Core-Widgets'
}

{ #category : #accessing }
GtMagrittePasswordEditorElement >> updateEditorText: aGtMagritteValue [
	| aValue aText |
	aValue := aGtMagritteValue currentValue.

	aText := aValue asRopedText.
	aText attribute: (BrTextReplacingAttribute new withCharacter: $*).
	self text: aText
]
