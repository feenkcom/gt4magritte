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

	weak at: 1 put: anElement
]

{ #category : #accessing }
GtMagritteElementHolder >> elementDo: aBlock [

	(weak at: 1) ifNotNil: aBlock
]

{ #category : #initialization }
GtMagritteElementHolder >> initialize [

	super initialize.

	weak := WeakArray new: 1
]
