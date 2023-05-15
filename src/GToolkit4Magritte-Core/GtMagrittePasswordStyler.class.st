Class {
	#name : #GtMagrittePasswordStyler,
	#superclass : #BlTextStyler,
	#category : #'GToolkit4Magritte-Core-Builders'
}

{ #category : #accessing }
GtMagrittePasswordStyler >> privateStyle: aText [
	^ aText attribute: (BrTextReplacingAttribute new withCharacter: $*)
]
