Class {
	#name : #GtMATextDescription,
	#superclass : #MAStringDescription,
	#category : #'GToolkit4Magritte-Core-Descriptions'
}

{ #category : #accessing }
GtMATextDescription class >> label [
	^ 'Text'
]

{ #category : #'accessing-defaults' }
GtMATextDescription >> defaultKind [
	^ BlText
]
