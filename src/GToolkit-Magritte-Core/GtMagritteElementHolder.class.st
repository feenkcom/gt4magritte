Class {
	#name : #GtMagritteElementHolder,
	#superclass : #Object,
	#instVars : [
		'weak'
	],
	#category : #'GToolkit-Magritte-Core-Support'
}

{ #category : #'instance creation' }
GtMagritteElementHolder class >> forElement: anElement [

	^ self new element: anElement
]

{ #category : #'instance creation' }
GtMagritteElementHolder class >> null [

	^ GtMagritteNullElementHolder default
]

{ #category : #accessing }
GtMagritteElementHolder >> element: anElement [

	weak := anElement asWeakReference
]

{ #category : #accessing }
GtMagritteElementHolder >> elementDo: aBlock [

	weak ifNotNil: [ :aWeak | (aWeak at: 1) ifNotNil: aBlock ]
]

{ #category : #printing }
GtMagritteElementHolder >> gtDisplayOn: aStream [

	| anElement |
	weak ifNil: [ 
		super gtDisplayOn: aStream.
		^ self ].

	self elementDo: [ :theElement | anElement := theElement ].

	anElement
		ifNil: [ aStream nextPutAll: 'a garbage collected element' ]
		ifNotNil: [ anElement gtDisplayOn: aStream ]
]
